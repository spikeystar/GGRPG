extends AnimatedSprite

#---------#
# Exports #
#---------#

export var alpha_clip = 0.5 # Decrease to 0.01 to dither transparent objects
export var depth_test_offset = Vector2.ZERO # Adjust so this is centered on the character's feet (relative to sprite origin)
export var feet_height = 0.0 # How far the character's feet extend past depth_test_offset.y, used to prevent clipping into the ground
export var height = 0.0 # The height of the platform standing on, or jump height
export var use_dithering = true # Dither alpha values
export var use_dither_blending = true # Offset alpha dithering pattern every frame to create a smoothing effect

#------------#
# Properties #
#------------#

var depth_test_mesh_top = null
var depth_test_mesh_bottom = null
var frame_width = 1
var frame_height = 1
var is_ready = false
var last_animation = null
var last_frame = -1
var last_frame_texture = null
var was_flip_h = false

#----------------#
# Node Lifecycle #
#----------------#

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		_clear_depth_test_meshes()

func _ready():
	is_ready = true
	_generate_meshes()

func _enter_tree():
	if is_ready:
		_generate_meshes()

func _exit_tree():
	_clear_depth_test_meshes()

func _physics_process(_delta):
	_update_mesh()

#-----------------#
# Private Methods #
#-----------------#

func _clear_depth_test_meshes():
	if depth_test_mesh_top:
		Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh_top)
		depth_test_mesh_top = null
	if depth_test_mesh_bottom:
		Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh_bottom)
		depth_test_mesh_bottom = null

func _generate_meshes():
	_clear_depth_test_meshes()
	
#	if not visible or not frames:
#		return
	
	var left = INF
	var right = -INF
	var bottom = INF
	var top = -INF
	
	for animation_name in frames.get_animation_names():
		var frame_count = frames.get_frame_count(animation_name)
		for i in range(0, frame_count):
			var texture = frames.get_frame(animation_name, i)
			var top_left = Vector2.ZERO
			var bottom_right = Vector2.ZERO
			if texture is AtlasTexture:
				bottom_right = texture.region.size
				if centered:
					top_left = -texture.region.size / 2
					bottom_right = texture.region.size / 2
			else:
				bottom_right = texture.get_size()
				if centered:
					top_left = -texture.get_size() / 2
					bottom_right = texture.get_size() / 2
			if top_left.x < left:
				left = top_left.x
			if top_left.y > top:
				top = top_left.y
			if bottom_right.x > right:
				right = bottom_right.x
			if bottom_right.y < bottom:
				bottom = bottom_right.y
	
	frame_width = right - left
	frame_height = bottom - top
	var top_body_frame_bottom = depth_test_offset.y
	
	var top_left = Vector2(left, top)
	var top_right = Vector2(right, top)
	var bottom_left = Vector2(left, top_body_frame_bottom)
	var bottom_right = Vector2(right, top_body_frame_bottom)
	
	var sprite_transform = Transform2D().scaled(scale).rotated(rotation)
	
	var vertices = PoolVector2Array()
	vertices.push_back(sprite_transform.xform(top_left))
	vertices.push_back(sprite_transform.xform(top_right))
	vertices.push_back(sprite_transform.xform(bottom_left))
	vertices.push_back(sprite_transform.xform(bottom_right))
	var uvs = PoolVector2Array()
	uvs.push_back(Vector2(0, 0))
	uvs.push_back(Vector2(1, 0))
	uvs.push_back(Vector2(0, (top_body_frame_bottom - top_left.y) / frame_height))
	uvs.push_back(Vector2(1, (top_body_frame_bottom - top_left.y) / frame_height))
	var depth_test = PoolRealArray()
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test_mesh_top = Global.depth_buffer.add_depth_test_mesh(
		vertices,
		uvs,
		depth_test,
		Vector2.ZERO,
		null,
		Vector2.ZERO
	)
	
	vertices = PoolVector2Array()
	vertices.push_back(sprite_transform.xform(Vector2(top_left.x, top_body_frame_bottom)))
	vertices.push_back(sprite_transform.xform(Vector2(top_left.x + frame_width, top_body_frame_bottom)))
	vertices.push_back(sprite_transform.xform(top_left + Vector2(0.0, frame_height)))
	vertices.push_back(sprite_transform.xform(top_left + Vector2(frame_width, frame_height)))
	uvs = PoolVector2Array()
	uvs.push_back(Vector2(0, (top_body_frame_bottom - top_left.y) / frame_height))
	uvs.push_back(Vector2(1, (top_body_frame_bottom - top_left.y) / frame_height))
	uvs.push_back(Vector2(0, 1))
	uvs.push_back(Vector2(1, 1))
	depth_test = PoolRealArray()
	depth_test.push_back(1)
	depth_test.push_back(1)
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test_mesh_bottom = Global.depth_buffer.add_depth_test_mesh(
		vertices,
		uvs,
		depth_test,
		Vector2.ZERO,
		null,
		Vector2.ZERO
	)
	
	var top_mesh = depth_test_mesh_top.get_ref()
	if top_mesh:
		top_mesh.material_override.set_shader_param("alpha_clip", alpha_clip)
		top_mesh.material_override.set_shader_param("dither_limit_min", 0.0 if use_dithering else 1.0)
		top_mesh.material_override.set_shader_param("dither_time_coord_multiplier", 1.0 if use_dither_blending else 0.0)
		top_mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
		top_mesh.material_override.set_shader_param("sprite_modulate", modulate * self_modulate)
	var bottom_mesh = depth_test_mesh_bottom.get_ref()
	if bottom_mesh:
		bottom_mesh.material_override.set_shader_param("alpha_clip", alpha_clip)
		bottom_mesh.material_override.set_shader_param("dither_limit_min", 0.0 if use_dithering else 1.0)
		bottom_mesh.material_override.set_shader_param("dither_time_coord_multiplier", 1.0 if use_dither_blending else 0.0)
		bottom_mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
		bottom_mesh.material_override.set_shader_param("sprite_modulate", modulate * self_modulate)
	was_flip_h = flip_h
	
	_update_mesh()

func _update_mesh():
	if not depth_test_mesh_top or not depth_test_mesh_bottom:
		return
	
	var top_mesh = depth_test_mesh_top.get_ref()
	var bottom_mesh = depth_test_mesh_bottom.get_ref()
	
	if animation != last_animation or frame != last_frame or flip_h != was_flip_h:
		last_animation = animation
		last_frame = frame
		
		var texture = frames.get_frame(animation, frame)
		if texture != last_frame_texture:
			last_frame_texture = texture
			if top_mesh:
				top_mesh.material_override.set_shader_param("sprite_texture_sampler", texture)
			if bottom_mesh:
				bottom_mesh.material_override.set_shader_param("sprite_texture_sampler", texture)
		
		var texture_region = Rect2(0, 0, 1, 1)
		if texture is AtlasTexture:
			var texture_size = texture.atlas.get_size()
			# This logic will need to change to account for frame_width & frame_height
			# if you ever use sprites that have different dimensions for each animation
			texture_region = Rect2(
				(texture.region.position.x / texture_size.x),
				(texture.region.position.y / texture_size.y),
				(texture.region.size.x / texture_size.x),
				(texture.region.size.y / texture_size.y)
			)
			if flip_h:
				texture_region.position.x = 1.0 - texture_region.position.x - texture_region.size.x
		if top_mesh:
			top_mesh.material_override.set_shader_param("sprite_texture_region", texture_region)
		if bottom_mesh:
			bottom_mesh.material_override.set_shader_param("sprite_texture_region", texture_region)
		
	if top_mesh:
		top_mesh.global_translation = Vector3(
			global_position.x + offset.x,
			global_position.y + offset.y,
			-(global_position.y + depth_test_offset.y + height) - 1
		)
		if flip_h != was_flip_h:
			top_mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)

	if bottom_mesh:
		bottom_mesh.global_translation = Vector3(
			global_position.x + offset.x,
			global_position.y + offset.y,
			-(global_position.y + depth_test_offset.y + height) - feet_height
		)
		if flip_h != was_flip_h:
			bottom_mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
	
	was_flip_h = flip_h

