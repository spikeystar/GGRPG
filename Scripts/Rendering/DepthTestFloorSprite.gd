extends Sprite

#---------#
# Exports #
#---------#

export var height = 0.0 # The height of the floor this sprite represents

#------------#
# Properties #
#------------#

var depth_test_mesh = null
var is_ready = false

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

#-----------------#
# Private Methods #
#-----------------#

func _clear_depth_test_meshes():
	if depth_test_mesh != null:
		Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh)
		depth_test_mesh = null

func _generate_meshes():
	_clear_depth_test_meshes()
	
	if not visible:
		return
	
	var texture_size = texture.get_size()
	var top_left = (-Vector2(texture_size.x / 2, texture_size.y / 2) if centered else Vector2.ZERO)
	var top_right = top_left + Vector2(texture_size.x, 0.0)
	var bottom_left = top_left + Vector2(0.0, texture_size.y)
	var bottom_right = top_left + Vector2(texture_size.x, texture_size.y)
	
	var sprite_transform = Transform2D().scaled(scale).rotated(rotation)

	var vertices = PoolVector2Array()
	vertices.push_back(sprite_transform.xform(top_left) + Vector2(0.0, global_position.y))
	vertices.push_back(sprite_transform.xform(top_right) + Vector2(0.0, global_position.y))
	vertices.push_back(sprite_transform.xform(bottom_left) + Vector2(0.0, global_position.y))
	vertices.push_back(sprite_transform.xform(bottom_right) + Vector2(0.0, global_position.y))
	var uvs = PoolVector2Array()
	uvs.push_back(Vector2(0, 0))
	uvs.push_back(Vector2(1, 0))
	uvs.push_back(Vector2(0, 1))
	uvs.push_back(Vector2(1, 1))
	var depth_test = PoolRealArray()
	var top = INF
	var bottom = -INF
	for vertex in vertices:
		if vertex.y < top:
			top = vertex.y
		if vertex.y > bottom:
			bottom = vertex.y
	for vertex in vertices:
		depth_test.push_back(1.0 - ((vertex.y - top) / (bottom - top)))
	depth_test_mesh = Global.depth_buffer.add_depth_test_mesh(
		vertices,
		uvs,
		depth_test,
		Vector2(-bottom, -top),
		texture,
		Vector2(global_position.x, 0.0)
	)
	
	var mesh = depth_test_mesh.get_ref()
	if mesh:
		mesh.material_override.set_shader_param("sprite_flip_h", -1 if flip_h else 1)
