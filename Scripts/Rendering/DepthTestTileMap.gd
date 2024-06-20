extends TileMap

#---------#
# Exports #
#---------#

export var height = 0.0 # The height of the floor this tile map represents
export var depth_test_offset = Vector2.ZERO

#------------#
# Properties #
#------------#

var depth_test_multimeshes = []
var is_ready = false
var frame_width = 0
var frame_height = 0

#----------------#
# Node Lifecycle #
#----------------#

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		_clear_depth_test_meshes()

func _ready():
	is_ready = true
	_generate_meshes()
	set_physics_process(false)
	set_process(false)

func _enter_tree():
	if is_ready:
		_generate_meshes()

func _exit_tree():
	_clear_depth_test_meshes()

#-----------------#
# Private Methods #
#-----------------#

func _clear_depth_test_meshes():
	for multimesh in depth_test_multimeshes:
		Global.depth_buffer.remove_depth_test_mesh(multimesh)
	depth_test_multimeshes = []

func _generate_meshes():
	_clear_depth_test_meshes()
	
	if not visible or not tile_set:
		return
		
	var top_body_frame_bottom = depth_test_offset.y
	
	var top_left = Vector2.ZERO
	var top_right = top_left + Vector2(frame_width, 0.0)
	var bottom_left = Vector2(top_left.x, top_body_frame_bottom)
	var bottom_right = Vector2(top_left.x + frame_width, top_body_frame_bottom)
		
	
	var cell_half_size = cell_size / 2.0
	
	for tile_id in tile_set.get_tiles_ids():
		var used_cells_by_id = get_used_cells_by_id(tile_id)
		if used_cells_by_id.size() > 0:
			var tile_texture = tile_set.tile_get_texture(tile_id)
			var tile_texture_size = tile_texture.get_size()
			var tile_texture_region = tile_set.tile_get_region(tile_id)
			var texture_half_size = tile_texture_region.size / 2.0
			
			var sprite_transform = Transform2D().scaled(scale).rotated(rotation)

			var vertices = PoolVector2Array()
			vertices.push_back(sprite_transform.xform(top_left))
			vertices.push_back(sprite_transform.xform(top_right))
			vertices.push_back(sprite_transform.xform(bottom_left))
			vertices.push_back(sprite_transform.xform(bottom_right))
			
			if centered_textures:
				vertices.push_back(Vector2(-texture_half_size.x, -texture_half_size.y))
				vertices.push_back(Vector2(texture_half_size.x, -texture_half_size.y))
				vertices.push_back(Vector2(-texture_half_size.x, texture_half_size.y))
				vertices.push_back(Vector2(texture_half_size.x, texture_half_size.y))
			else:
				vertices.push_back(-cell_half_size + Vector2(0.0, 0.0))
				vertices.push_back(-cell_half_size + Vector2(tile_texture_region.size.x, 0.0))
				vertices.push_back(-cell_half_size + Vector2(0.0, tile_texture_region.size.y))
				vertices.push_back(-cell_half_size + Vector2(tile_texture_region.size.x, tile_texture_region.size.y))
			var uvs = PoolVector2Array()
			uvs.push_back(Vector2(tile_texture_region.position.x / tile_texture_size.x, tile_texture_region.position.y / tile_texture_size.y))
			uvs.push_back(Vector2((tile_texture_region.position.x + tile_texture_region.size.x) / tile_texture_size.x, tile_texture_region.position.y / tile_texture_size.y))
			uvs.push_back(Vector2(tile_texture_region.position.x / tile_texture_size.x, (tile_texture_region.position.y + tile_texture_region.size.y) / tile_texture_size.y))
			uvs.push_back(Vector2((tile_texture_region.position.x + tile_texture_region.size.x) / tile_texture_size.x, (tile_texture_region.position.y + tile_texture_region.size.y) / tile_texture_size.y))
			var depth_test = PoolRealArray()
			depth_test.push_back(1)
			depth_test.push_back(1)
			depth_test.push_back(0)
			depth_test.push_back(0)
			
			var instances = []
			if mode == TileMap.MODE_ISOMETRIC:
				var cell_origin = Vector2(0.0, cell_size.y / 2)
				for cell_position in used_cells_by_id:
					var position = Vector2(
						cell_origin.x + (cell_position.x * cell_size.x / 2) - (cell_position.y * cell_size.x / 2),
						cell_origin.y + (cell_position.x + cell_position.y) * cell_size.y / 2
					)
					instances.push_back({
						"position": Vector3(
							position.x,
							position.y,
							-position.y - height - cell_origin.y
						)
					})
			
			depth_test_multimeshes.push_back(
				Global.depth_buffer.add_depth_test_multimesh(
					vertices,
					uvs,
					depth_test,
					Vector2(0.1, tile_texture_size.y),
					tile_texture,
					instances,
					global_position
				)
			)
	
