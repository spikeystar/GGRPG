extends Node2D

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
var frame_width = 0
var frame_height = 0
var is_ready = false
var last_frame = -1
var was_flip_h = false

#----------------#
# Node Lifecycle #
#----------------#

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		_clear_depth_test_meshes()

func _ready():
	is_ready = true
	_calculate_frame_size()
	_generate_meshes()

func _enter_tree():
	if is_ready:
		_calculate_frame_size()
		_generate_meshes()

func _exit_tree():
	_clear_depth_test_meshes()

func _physics_process(_delta):
	if depth_test_mesh_top:
		var top_mesh = depth_test_mesh_top.get_ref()
		if top_mesh:
			top_mesh.global_translation = Vector3(
				global_position.x,
				global_position.y,
				-(global_position.y + depth_test_offset.y + height) - 1
			)

	if depth_test_mesh_bottom:
		var bottom_mesh = depth_test_mesh_bottom.get_ref()
		if bottom_mesh:
			bottom_mesh.global_translation = Vector3(
				global_position.x,
				global_position.y,
				-(global_position.y + depth_test_offset.y + height) - feet_height
			)


#-----------------#
# Private Methods #
#-----------------#

func _calculate_frame_size():
	if texture:
		frame_width = round(texture.get_size().x / hframes)
		frame_height = round(texture.get_size().y / vframes)

func _clear_depth_test_meshes():
	if depth_test_mesh_top:
		Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh_top)
		depth_test_mesh_top = null
	if depth_test_mesh_bottom:
		Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh_bottom)
		depth_test_mesh_bottom = null

func _generate_meshes():
	_clear_depth_test_meshes()
	
	if not visible:
		return
	
	var top_body_frame_bottom = depth_test_offset.y
	
	var top_left = (-Vector2(frame_width / 2, frame_height / 2) if centered else Vector2.ZERO)
	var top_right = top_left + Vector2(frame_width, 0.0)
	var bottom_left = Vector2(top_left.x, top_body_frame_bottom)
	var bottom_right = Vector2(top_left.x + frame_width, top_body_frame_bottom)
	
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
		texture,
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
		texture,
		Vector2.ZERO
	)
	
	var top_mesh = depth_test_mesh_top.get_ref()
	if top_mesh:
		top_mesh.material_override.set_shader_param("alpha_clip", alpha_clip)
		top_mesh.material_override.set_shader_param("dither_limit_min", 0.0 if use_dithering else 1.0)
		top_mesh.material_override.set_shader_param("dither_time_coord_multiplier", 1.0 if use_dither_blending else 0.0)
		top_mesh.material_override.set_shader_param("sprite_animation_hframes", hframes)
		top_mesh.material_override.set_shader_param("sprite_animation_vframes", vframes)
		top_mesh.material_override.set_shader_param("sprite_animation_frame", frame)
		top_mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
		top_mesh.material_override.set_shader_param("sprite_modulate", modulate * self_modulate)
	var bottom_mesh = depth_test_mesh_bottom.get_ref()
	if bottom_mesh:
		bottom_mesh.material_override.set_shader_param("alpha_clip", alpha_clip)
		bottom_mesh.material_override.set_shader_param("dither_limit_min", 0.0 if use_dithering else 1.0)
		bottom_mesh.material_override.set_shader_param("dither_time_coord_multiplier", 1.0 if use_dither_blending else 0.0)
		bottom_mesh.material_override.set_shader_param("sprite_animation_hframes", hframes)
		bottom_mesh.material_override.set_shader_param("sprite_animation_vframes", vframes)
		bottom_mesh.material_override.set_shader_param("sprite_animation_frame", frame)
		bottom_mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
		bottom_mesh.material_override.set_shader_param("sprite_modulate", modulate * self_modulate)
	was_flip_h = flip_h

