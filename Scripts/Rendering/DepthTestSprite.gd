extends Sprite

#---------#
# Exports #
#---------#

export var depth_test_offset = Vector2.ZERO # Adjust so this is centered on the character's feet (relative to sprite origin)
export var height = 0.0 # The height of the platform standing on, or jump height

#------------#
# Properties #
#------------#

var depth_test_mesh = null
var frame_width = 0
var frame_height = 0
var last_frame = -1
var was_flip_h = false

#----------------#
# Node Lifecycle #
#----------------#

func _enter_tree():
	_calculate_frame_size()
	
	var top_left = (-Vector2(frame_width / 2, frame_height / 2) if centered else Vector2.ZERO)

	var top_body_frame_bottom = frame_height
	
	var vertices = PoolVector2Array()
	vertices.push_back(top_left)
	vertices.push_back(top_left + Vector2(frame_width, 0.0))
	vertices.push_back(top_left + Vector2(0.0, top_body_frame_bottom))
	vertices.push_back(top_left + Vector2(frame_width, top_body_frame_bottom))
	var uvs = PoolVector2Array()
	uvs.push_back(Vector2(0, 0))
	uvs.push_back(Vector2(1, 0))
	uvs.push_back(Vector2(0, top_body_frame_bottom / frame_height))
	uvs.push_back(Vector2(1, top_body_frame_bottom / frame_height))
	var depth_test = PoolRealArray()
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test.push_back(0)
	depth_test_mesh = Global.depth_buffer.add_depth_test_mesh(
		vertices,
		uvs,
		depth_test,
		Vector2.ZERO,
		texture,
		Vector2.ZERO
	)
	var mesh = depth_test_mesh.get_ref()
	if mesh:
		mesh.material_override.set_shader_param("sprite_animation_hframes", hframes)
		mesh.material_override.set_shader_param("sprite_animation_vframes", vframes)
		mesh.material_override.set_shader_param("sprite_animation_frame", frame)
		mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
	was_flip_h = flip_h

func _exit_tree():
	Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh)
	depth_test_mesh = null

func _physics_process(_delta):
	if depth_test_mesh:
		var mesh = depth_test_mesh.get_ref()
		if mesh:
			mesh.global_translation = Vector3(
				global_position.x + offset.x,
				global_position.y + offset.y,
				-(global_position.y + depth_test_offset.y + height)
			)
			if frame != last_frame:
				last_frame = frame
				mesh.material_override.set_shader_param("sprite_animation_frame", frame)
			if flip_h != was_flip_h:
				was_flip_h = flip_h
				mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)

#---------#
# Setters #
#---------#

func _set_hframes(new_hframes):
	hframes = new_hframes
	update()

func _set_vframes(new_vframes):
	vframes = new_vframes
	update()

func _set_frame(new_frame):
	frame = new_frame
	update()

#-----------------#
# Private Methods #
#-----------------#

func _calculate_frame_size():
	if texture:
		frame_width = round(texture.get_size().x / hframes)
		frame_height = round(texture.get_size().y / vframes)
