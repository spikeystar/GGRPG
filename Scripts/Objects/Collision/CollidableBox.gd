# This node generates a basic collision box that the player can jump on to, and handles depth sorting of the sprite

tool
extends Node2D

#---------#
# Imports #
#---------#

var collision_body_script = preload("res://Scripts/Objects/Collision/CollidableBoxCollisionBody.gd")
var sprite_mesh_shader = preload("res://Scripts/Rendering/SpriteMesh.gdshader")
var floor_layer_script = preload("res://Scripts/Objects/Collision/FloorLayer.gd")
var floor_setter_script = preload("res://Scripts/Objects/Collision/FloorSetter.gd")

#---------#
# Exports #
#---------#

# Width/height of each isometric tile
export var tile_size = Vector2(62, 22) setget set_tile_size

# Adjust how many units in the tilemap the box takes up.
#   - a value of 1,1 means the space of tile_size is taken (62 x 22 by default)
#   - you should set up tile_size so that grid_size is as close to integer values as possible.
#   - increasing x expands the box diagonally up left (-x axis on tile map).
#   - increasing y expands the box diagonally up right (-y axis on tile map).
export var grid_size = Vector2(1, 1) setget set_grid_size

# Sprite texture to use
export(Texture) var texture setget set_texture

# Adjust the scale of the texture for display
export var texture_scale = Vector2(1.0, 1.0) setget set_texture_scale

# Adjust the offset so the bottom corner of the sprite matches the bottom corner of the collision box
export var texture_offset = Vector2.ZERO setget set_texture_offset

# Height of the top of the collision box, in pixels
export var height = 0.0 setget set_height

# Height of the floor underneath the collision box, used to raise object from the ground
export var floor_height = 0.0 setget set_floor_height

# Use to adjust the 3D position used for y sorting (defaults to centered on the floor)
# This can work around issues where the default cases bad sorting
export var depth_test_offset = Vector3.ZERO setget set_depth_test_offset

# Enable/disable preview of the collision box in editor
export var preview_collision_box = true setget set_preview_collision_box

# If using a spritesheet, the number of frames that span the image horizontally
export var animation_hframes = 1 setget set_animation_hframes

# If using a spritesheet, the number of frames that span the image vertically
export var animation_vframes = 1 setget set_animation_vframes

# If using a spritesheet, the current frame of animation
export var animation_frame = 0 setget set_animation_frame

# Dither alpha values, disabled when use_transparency is true
export var use_dithering = true

# Offset alpha dithering pattern every frame to create a smoothing effect
export var use_dither_blending = true

# Allow partial transparency, but greatly reduces depth drawing accuracy
export var use_transparency: bool = false

# Set to true in order to make the box respond to position / height updates
export var always_update: bool = false setget set_always_update

#------------#
# Properties #
#------------#

const COLLISION_PREVIEW_DRAW_OFFSET = 1000.0

var collider_edges = null
var collision_body = null # blocks player/npc from moving here
var collision_body_shape = null # belongs to collision_body
var collision_preview_mesh = null # editor preview mesh of collision box
var depth_test_meshes = [] # keep track of the meshes created for depth testing
var floor_notify_area = null # notifies player/npc of floor height when collision_body non-blocking
var floor_notify_area_shape = null # belongs to floor_notify_area
var half_tile_width = 63.0 / 2.0
var half_tile_height = 28.0 / 2.0
var mesh_ysort_containers = [] # texture is split into multiple sprites with texture regions for y-sorting
var meshes = []
var is_queued_generate_collider = false
var is_queued_generate_collision_box_preview = false
var is_queued_generate_meshes = false
var is_ready = false # _ready() already called

#-------------------#
# Getters / Setters #
#-------------------#

func set_tile_size(new_tile_size):
	tile_size = new_tile_size
	half_tile_width = tile_size.x / 2.0
	half_tile_height = tile_size.y / 2.0
	if is_ready:
		_generate_collider_edges()
		_queue_generate_collider()
		_queue_generate_meshes()
		_queue_generate_collision_box_preview()

func set_texture(new_texture):
	texture = new_texture
	if is_ready:
		_queue_generate_meshes()

func set_texture_scale(new_texture_scale):
	texture_scale = new_texture_scale
	if is_ready:
		_queue_generate_meshes()

func set_texture_offset(new_texture_offset):
	texture_offset = new_texture_offset
	if is_ready:
		_queue_generate_meshes()

func set_grid_size(new_grid_size):
	grid_size = new_grid_size
	if is_ready:
		_generate_collider_edges()
		_queue_generate_collider()
		_queue_generate_meshes()
		_queue_generate_collision_box_preview()

func set_height(new_height):
	height = new_height
	if is_ready:
		_queue_generate_meshes()
		_queue_generate_collider()
		_queue_generate_collision_box_preview()

func set_floor_height(new_floor_height):
	floor_height = new_floor_height
	if is_ready:
		_queue_generate_meshes()
		_queue_generate_collider()
		_queue_generate_collision_box_preview()

func set_depth_test_offset(new_depth_test_offset):
	depth_test_offset = new_depth_test_offset
	if is_ready:
		_queue_generate_meshes()

func set_preview_collision_box(new_preview_collision_box):
	preview_collision_box = new_preview_collision_box
	if is_ready:
		_queue_generate_collision_box_preview()

func set_animation_hframes(new_animation_hframes):
	animation_hframes = new_animation_hframes
	if is_ready:
		_queue_generate_meshes()

func set_animation_vframes(new_animation_vframes):
	animation_vframes = new_animation_vframes
	if is_ready:
		_queue_generate_meshes()

func set_animation_frame(new_animation_frame):
	animation_frame = new_animation_frame
	if depth_test_meshes.size() > 0:
		for mesh in meshes:
			if mesh != null:
				mesh.material.set_shader_param("sprite_animation_frame", animation_frame)
		for mesh_weakref in depth_test_meshes:
			var mesh = mesh_weakref.get_ref()
			if mesh:
				mesh.material_override.set_shader_param("sprite_animation_frame", animation_frame)
	elif is_ready:
		_queue_generate_meshes()

func set_always_update(new_always_update):
	always_update = new_always_update
	set_physics_process(always_update)
	set_process(always_update)

#----------------#
# Node Lifecycle #
#----------------#

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		_clear_depth_test_meshes()

func _ready():
	is_ready = true
	
	set_always_update(always_update)
	
	_initialize_nodes()

func _enter_tree():
	if is_ready:
		_initialize_nodes()

func _exit_tree():
	if is_ready:
		_clear_depth_test_meshes()

func _physics_process(delta):
	for depth_test_mesh in depth_test_meshes:
		var mesh = depth_test_mesh.get_ref()
		if mesh:
			mesh.global_translation = Vector3(
				global_position.x,
				global_position.y - floor_height,
				0.0
			)

#---------#
# Methods #
#---------#

func _initialize_nodes():
	for child in get_children():
		if child != null and weakref(child).get_ref():
			child.queue_free()
	
	collider_edges = null
	collision_body = null
	collision_body_shape = null
	collision_preview_mesh = null
	floor_notify_area = null
	floor_notify_area_shape = null
	mesh_ysort_containers = []
	meshes = []
	
	half_tile_width = tile_size.x / 2.0
	half_tile_height = tile_size.y / 2.0

	_generate_collider_edges()
	_queue_generate_collider()
	_queue_generate_meshes()
	_queue_generate_collision_box_preview()

func _clear_depth_test_meshes():
	for depth_test_mesh in depth_test_meshes:
		Global.depth_buffer.remove_depth_test_mesh(depth_test_mesh)
	depth_test_meshes = []

func _queue_generate_collider():
	if not is_queued_generate_collider:
		is_queued_generate_collider = true
		call_deferred("_generate_collider")

func _generate_collider():
	is_queued_generate_collider = false
	if Engine.editor_hint:
		return
	
	if collision_body == null or not weakref(collision_body).get_ref():
		collision_body = StaticBody2D.new()
		collision_body.name = "CollisionBody"
		collision_body.set_script(collision_body_script)
		add_child(collision_body)
	
	if floor_notify_area == null or not weakref(floor_notify_area).get_ref():
		floor_notify_area = Area2D.new()
		floor_notify_area.name = "FloorNotifyArea"
		floor_notify_area.set_script(floor_setter_script)
		add_child(floor_notify_area)
	
	if collision_body_shape != null:
		collision_body_shape.queue_free()
		collision_body_shape = null
	
	if floor_notify_area_shape != null:
		floor_notify_area_shape.queue_free()
		floor_notify_area_shape = null
	
	collision_body_shape = CollisionPolygon2D.new()
	floor_notify_area_shape = CollisionPolygon2D.new()
	
	for shape in [collision_body_shape, floor_notify_area_shape]:
		shape.name = "CollisionShape"
		var polygon = PoolVector2Array()
		polygon.push_back(collider_edges.top)
		polygon.push_back(collider_edges.right)
		polygon.push_back(collider_edges.bottom)
		polygon.push_back(collider_edges.left)
		polygon.push_back(collider_edges.top)
		shape.polygon = polygon
		shape.set_script(floor_layer_script)
		shape.height = floor_height + height
	
	collision_body.add_child(collision_body_shape)
	floor_notify_area.add_child(floor_notify_area_shape)
	floor_notify_area.height = floor_height + height
	
	collision_body.discover_shapes()

func _generate_collider_edges():
	collider_edges = {
		"left": Vector2(
			-half_tile_width - ((grid_size.x - 1.0) * half_tile_width),
			-((grid_size.x - 1.0) * half_tile_height)
		),
		"top": Vector2(
			-(half_tile_width * grid_size.x) + (half_tile_width * grid_size.y),
			- half_tile_height - ((grid_size.x + grid_size.y - 2.0) * half_tile_height)
		),
		"bottom": Vector2(
			0.0,
			+ half_tile_height
		),
		"right": Vector2(
			half_tile_width + ((grid_size.y - 1.0) * half_tile_width),
			-((grid_size.y - 1.0) * half_tile_height)
		),
	}

func _queue_generate_meshes():
	if not is_queued_generate_meshes:
		is_queued_generate_meshes = true
		call_deferred("_generate_meshes")

func _generate_meshes():
	is_queued_generate_meshes = false
	
	_clear_depth_test_meshes()
	
	if mesh_ysort_containers.size() > 0:
		for tx in mesh_ysort_containers:
			tx.queue_free()
		mesh_ysort_containers = []
	
	if meshes.size() > 0:
		for tx in meshes:
			tx.queue_free()
		meshes = []
	
	if not texture:
		return
	
	var texture_size = texture.get_size() * texture_scale
	texture_size = Vector2(texture_size.x / animation_hframes, texture_size.y / animation_vframes)
	var min_grid_size = min(grid_size.x, grid_size.y)
	var tile_step_grid_size = min_grid_size / ceil(min_grid_size)
	var tile_step_width = (tile_step_grid_size * tile_size.x) / 2.0
	var tile_step_height = tile_step_width * (tile_size.y / tile_size.x)
	var left_half_title_size = grid_size.x / tile_step_grid_size
	var right_half_title_size = grid_size.y / tile_step_grid_size
	var left_half_tile_count = ceil(left_half_title_size)
	var right_half_tile_count = ceil(right_half_title_size)
	var left_of_bottom_corner_width = half_tile_width + ((grid_size.x - 1.0) * half_tile_width)
	var right_of_bottom_corner_width = half_tile_width + ((grid_size.y - 1.0) * half_tile_width)
	var h_margin = (texture_size.x - (left_of_bottom_corner_width + right_of_bottom_corner_width)) / 2.0
	var tile_step_origin_height_offset = half_tile_height - tile_step_height
	
	var texture_origin = Vector2(
		h_margin + left_of_bottom_corner_width,
		texture_size.y - half_tile_height
	) - texture_offset
	
	var texture_clip_bounds = Rect2(
		-texture_origin.x,
		-texture_origin.y,
		texture_size.x - texture_origin.x,
		texture_size.y - texture_origin.y
	)
	
	var front_corner_depth = -(global_position.y + half_tile_height)
	
	# Render left side of box
	for tile_count in range(0, left_half_tile_count):
		# Generate offset points relative to texture_origin
		var is_texture_edge = tile_count >= left_half_tile_count - 1
		var h_coord = -(tile_count * tile_step_width)
		var left = h_coord - tile_step_width
		var right = h_coord
		var bottom = texture_size.y - texture_origin.y
		var bottom_left = Vector2(left, bottom)
		var bottom_right = Vector2(right, bottom)
		var top_right = Vector2(
			right,
			-height -((tile_count - 1) * tile_step_height) + tile_step_origin_height_offset
		)
		var top_left = Vector2(
			left,
			Geometry.line_intersects_line_2d(Vector2(left, 0.0), Vector2(0.0, 1.0), top_right, Vector2(-tile_step_width, -tile_step_height).normalized()).y
		)
		
		# Generate a textured mesh for the left side
		var vertices = PoolVector2Array()
		var depth_test = PoolRealArray()
		vertices.push_back(bottom_left)
		depth_test.push_back(1)
		vertices.push_back(top_left)
		depth_test.push_back(1)
		vertices.push_back(bottom_right)
		depth_test.push_back(0)
		vertices.push_back(top_right)
		depth_test.push_back(0)
		var depth_range = Vector2(front_corner_depth + (tile_count * tile_step_height), front_corner_depth + ((tile_count + 1) * tile_step_height))
		_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, Vector3(
			global_position.x + right,
			global_position.y + top_right.y + height - tile_step_height,
			floor_height
		) + depth_test_offset)
		
		# Generate a mesh containing the remainder of the image on the left side that's not on box
		if is_texture_edge:
			left = texture_clip_bounds.position.x
			right = h_coord - tile_step_width
			bottom_left = Vector2(left, bottom)
			bottom_right = Vector2(right, bottom)
			top_right = top_left
			top_left = Vector2(
				left,
				Geometry.line_intersects_line_2d(Vector2(left, 0.0), Vector2(0.0, 1.0), top_right, Vector2(-tile_step_width, -tile_step_height).normalized()).y
			)
			vertices = PoolVector2Array()
			depth_test = PoolRealArray()
			vertices.push_back(bottom_left)
			depth_test.push_back(1)
			vertices.push_back(top_left)
			depth_test.push_back(1)
			vertices.push_back(bottom_right)
			depth_test.push_back(1)
			vertices.push_back(top_right)
			depth_test.push_back(1)
			depth_range = Vector2(front_corner_depth + ((tile_count + 1) * tile_step_height), front_corner_depth + ((tile_count + 1) * tile_step_height))
			_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, Vector3(
				global_position.x + right,
				global_position.y + top_right.y + height - tile_step_height,
				floor_height
			) + depth_test_offset)
			
	
	# Render right side of box
	for tile_count in range(0, right_half_tile_count):
		# Generate offset points relative to texture_origin
		var is_texture_edge = tile_count >= right_half_tile_count - 1
		var h_coord = tile_count * tile_step_width
		var left = h_coord
		var right = h_coord + tile_step_width
		var bottom = texture_size.y - texture_origin.y
		var bottom_left = Vector2(left, bottom)
		var bottom_right = Vector2(right, bottom)
		var top_left = Vector2(
			left,
			-height -((tile_count - 1) * tile_step_height) + tile_step_origin_height_offset
		)
		var top_right = Vector2(
			right,
			Geometry.line_intersects_line_2d(Vector2(right, 0.0), Vector2(0.0, 1.0), top_left, Vector2(half_tile_width, -half_tile_height).normalized()).y
		)
		
		# Generate a textured mesh for the right side
		var vertices = PoolVector2Array()
		var depth_test = PoolRealArray()
		vertices.push_back(bottom_left)
		depth_test.push_back(0)
		vertices.push_back(top_left)
		depth_test.push_back(0)
		vertices.push_back(bottom_right)
		depth_test.push_back(1)
		vertices.push_back(top_right)
		depth_test.push_back(1)
		var depth_range = Vector2(front_corner_depth + (tile_count * tile_step_height), front_corner_depth + ((tile_count + 1) * tile_step_height))
		_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, Vector3(
			global_position.x + left,
			global_position.y + top_left.y + height - tile_step_height,
			floor_height
		) + depth_test_offset)
		
		# Generate a mesh containing the remainder of the image on the right side that's not on box
		if is_texture_edge:
			left = h_coord + tile_step_width
			right = texture_clip_bounds.size.x
			bottom_left = Vector2(left, bottom)
			bottom_right = Vector2(right, bottom)
			top_left = top_right
			top_right = Vector2(
				right,
				Geometry.line_intersects_line_2d(Vector2(right, 0.0), Vector2(0.0, 1.0), top_left, Vector2(half_tile_width, -half_tile_height).normalized()).y
			)
			vertices = PoolVector2Array()
			depth_test = PoolRealArray()
			vertices.push_back(bottom_left)
			depth_test.push_back(1)
			vertices.push_back(top_left)
			depth_test.push_back(1)
			vertices.push_back(bottom_right)
			depth_test.push_back(1)
			vertices.push_back(top_right)
			depth_test.push_back(1)
			depth_range = Vector2(front_corner_depth + ((tile_count + 1) * tile_step_height), front_corner_depth + ((tile_count + 1) * tile_step_height))
			_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, Vector3(
				global_position.x + left,
				global_position.y + top_left.y + height - tile_step_height,
				floor_height
			) + depth_test_offset)
	
	
	# Render top of box
	for x_tile in range(0, left_half_tile_count):
		for y_tile in range(0, right_half_tile_count):
			var is_last_x_tile = x_tile == left_half_tile_count - 1
			var is_last_y_tile = y_tile == right_half_tile_count - 1
			
			var x_tile_offset = left_half_title_size - 1 if is_last_x_tile else x_tile
			var y_tile_offset = right_half_title_size - 1 if is_last_y_tile else y_tile
			
			var tile_center = Vector2(
				-(tile_step_width * x_tile_offset) + (tile_step_width * y_tile_offset),
				- height + tile_step_origin_height_offset +
					((x_tile_offset + y_tile_offset) * -(tile_step_height))
			)
			var left = tile_center.x - tile_step_width
			var right = tile_center.x + tile_step_width
			var top = tile_center.y - tile_step_height
			var bottom = tile_center.y + tile_step_height
			
			var left_corner = Vector2(left, tile_center.y)
			var right_corner = Vector2(right, tile_center.y)
			var top_corner = Vector2(tile_center.x, top)
			var bottom_corner = Vector2(tile_center.x, bottom)
			
			# Generate a textured mesh for the top side
			var vertices = PoolVector2Array()
			var depth_test = PoolRealArray()
			vertices.push_back(left_corner)
			depth_test.push_back(0.5)
			vertices.push_back(top_corner)
			depth_test.push_back(1)
			vertices.push_back(bottom_corner)
			depth_test.push_back(0)
			vertices.push_back(right_corner)
			depth_test.push_back(0.5)
			var depth_range = Vector2(
				front_corner_depth + ((x_tile + y_tile) * tile_step_height),
				front_corner_depth + ((x_tile + y_tile) * tile_step_height) + (tile_step_height * 2)
			)
			var depth_test_position = Vector3(
				global_position.x - tile_center.x,
				global_position.y + (tile_step_origin_height_offset + ((x_tile + y_tile) * -(tile_step_height))),
				floor_height
			) + depth_test_offset
			
			_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, depth_test_position)
			
			var left_edge = Vector2.ZERO
			var right_edge = Vector2.ZERO
			
			# Generate a textured mesh for leftover data on left side of image
			if is_last_x_tile:
				left_edge = Geometry.line_intersects_line_2d(
					Vector2(texture_clip_bounds.position.x, 0.0),
					Vector2(0.0, 1.0),
					Vector2(tile_center.x, top),
					Vector2(-half_tile_width, -half_tile_height).normalized()
				)
				var p0 = left_edge
				var p1 = Vector2(left_edge.x, left_edge.y + (tile_step_height * 2))
				var p2 = Vector2(tile_center.x, top)
				var p3 = Vector2(left, tile_center.y)
				vertices = PoolVector2Array()
				depth_test = PoolRealArray()
				vertices.push_back(p0)
				depth_test.push_back(1)
				vertices.push_back(p1)
				depth_test.push_back(1)
				vertices.push_back(p2)
				depth_test.push_back(1)
				vertices.push_back(p3)
				depth_test.push_back(1)
				depth_range = Vector2(front_corner_depth + ((x_tile + y_tile) * tile_step_height * 2) + tile_step_height, front_corner_depth + ((x_tile + y_tile) * tile_step_height * 2) + tile_step_height)
				_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, depth_test_position)
			
			# Generate a textured mesh for leftover data on right side of image
			if is_last_y_tile:
				right_edge = Geometry.line_intersects_line_2d(
					Vector2(texture_clip_bounds.size.x, 0.0),
					Vector2(0.0, 1.0),
					Vector2(tile_center.x, top),
					Vector2(half_tile_width, -half_tile_height).normalized()
				)
				var p0 = right_edge
				var p1 = Vector2(right_edge.x, right_edge.y + (tile_step_height * 2))
				var p2 = Vector2(tile_center.x, top)
				var p3 = Vector2(right, tile_center.y)
				vertices = PoolVector2Array()
				depth_test = PoolRealArray()
				vertices.push_back(p0)
				depth_test.push_back(1)
				vertices.push_back(p1)
				depth_test.push_back(1)
				vertices.push_back(p2)
				depth_test.push_back(1)
				vertices.push_back(p3)
				depth_test.push_back(1)
				depth_range = Vector2(front_corner_depth + ((x_tile + y_tile) * tile_step_height * 2) + tile_step_height, front_corner_depth + ((x_tile + y_tile) * tile_step_height * 2) + tile_step_height)
				_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, depth_test_position)
			
			# Generate a textured mesh for leftover data on top side of image
			if is_last_x_tile and is_last_y_tile:
				var p0 = Vector2(texture_clip_bounds.position.x, -texture_origin.y)
				var p1 = left_edge
				var p2 = Vector2(tile_center.x, -texture_origin.y)
				var p3 = Vector2(tile_center.x, top)
				var p4 = Vector2(texture_clip_bounds.size.x, -texture_origin.y)
				var p5 = right_edge
				vertices = PoolVector2Array()
				depth_test = PoolRealArray()
				vertices.push_back(p0)
				depth_test.push_back(1)
				vertices.push_back(p1)
				depth_test.push_back(1)
				vertices.push_back(p2)
				depth_test.push_back(1)
				vertices.push_back(p3)
				depth_test.push_back(1)
				vertices.push_back(p4)
				depth_test.push_back(1)
				vertices.push_back(p5)
				depth_test.push_back(1)
				depth_range = Vector2(front_corner_depth + ((x_tile + y_tile) * tile_step_height * 2) + tile_step_height * 2, front_corner_depth + ((x_tile + y_tile) * tile_step_height * 2) + tile_step_height * 2)
				_generate_mesh(vertices, depth_test, depth_range, texture_origin, texture_size, depth_test_position)


func _generate_mesh(
	vertices: PoolVector2Array,
	depth_test: PoolRealArray,
	depth_range: Vector2,
	texture_origin: Vector2,
	texture_size: Vector2,
	sort_position: Vector3
):
	# Generate y-sort container
	var y_sort = Node2D.new()
	y_sort.name = "YSort"
	add_child(y_sort)
	y_sort.global_position = Vector2(
		global_position.x,
		Global.calculate_y_sort(Vector3(sort_position.x, sort_position.y, sort_position.z))
	)
	mesh_ysort_containers.push_back(y_sort)
	
	# Generate UVs
	var uvs = PoolVector2Array()
	var vertex_index: int = 0
	for vertex in vertices:
		uvs.push_back((vertex + texture_origin) / texture_size)
		vertices[vertex_index] = vertex
		vertex_index += 1
	
	# Generate a textured mesh
	var array_mesh = Mesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_TEX_UV] = uvs
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, arrays)
	var mesh_instance = MeshInstance2D.new()
	mesh_instance.name = "TexturedMeshInstance2D"
	mesh_instance.mesh = array_mesh
	mesh_instance.texture = texture
	mesh_instance.material = ShaderMaterial.new()
	mesh_instance.material.shader = sprite_mesh_shader
	mesh_instance.material.set_shader_param("sprite_animation_hframes", animation_hframes)
	mesh_instance.material.set_shader_param("sprite_animation_vframes", animation_vframes)
	mesh_instance.material.set_shader_param("sprite_animation_frame", animation_frame)
	y_sort.add_child(mesh_instance)
	mesh_instance.global_position = global_position + Vector2(0.0, -floor_height)
	meshes.push_back(mesh_instance)
	
	if visible:
		var mesh_weakref = Global.depth_buffer.add_depth_test_mesh(
			vertices,
			uvs,
			depth_test,
			depth_range,
			texture,
			global_position + Vector2(0.0, -floor_height),
			use_transparency
		)
		var mesh = mesh_weakref.get_ref()
		if mesh:
			depth_test_meshes.push_back(mesh_weakref)
			if animation_hframes != 1 or animation_vframes != 1:
				mesh.material_override.set_shader_param("sprite_animation_hframes", animation_hframes)
				mesh.material_override.set_shader_param("sprite_animation_vframes", animation_vframes)
				mesh.material_override.set_shader_param("sprite_animation_frame", animation_frame)
			mesh.material_override.set_shader_param("dither_limit_min", 0.0 if use_dithering else 1.0)
			mesh.material_override.set_shader_param("dither_time_coord_multiplier", 1.0 if use_dither_blending else 0.0)
			mesh.material_override.set_shader_param("sprite_modulate", modulate * self_modulate)

func _queue_generate_collision_box_preview():
	if not is_queued_generate_collision_box_preview:
		is_queued_generate_collision_box_preview = true
		call_deferred("_generate_collision_box_preview")

func _generate_collision_box_preview():
	is_queued_generate_collision_box_preview = false
	if Engine.editor_hint and preview_collision_box:
		if collision_preview_mesh == null or not weakref(collision_preview_mesh).get_ref():
			collision_preview_mesh = MeshInstance2D.new()
		var array_mesh = ArrayMesh.new()
		var top_left = collider_edges.left + Vector2(0.0, COLLISION_PREVIEW_DRAW_OFFSET - height - floor_height)
		var top_top = collider_edges.top + Vector2(0.0, COLLISION_PREVIEW_DRAW_OFFSET - height - floor_height)
		var top_bottom = collider_edges.bottom + Vector2(0.0, COLLISION_PREVIEW_DRAW_OFFSET - height - floor_height)
		var top_right = collider_edges.right + Vector2(0.0, COLLISION_PREVIEW_DRAW_OFFSET - height - floor_height)
		var bottom_left = top_left + Vector2(0.0, height)
		var bottom_top = top_top + Vector2(0.0, height)
		var bottom_bottom = top_bottom + Vector2(0.0, height)
		var bottom_right = top_right + Vector2(0.0, height)
		
		# Floor (+Z)
		if floor_height != 0:
			var floor_vertices = PoolVector2Array()
			floor_vertices.push_back(bottom_left + Vector2(0.0, floor_height))
			floor_vertices.push_back(bottom_top + Vector2(0.0, floor_height))
			floor_vertices.push_back(bottom_bottom + Vector2(0.0, floor_height))
			floor_vertices.push_back(bottom_right + Vector2(0.0, floor_height))
			var floor_colors = PoolColorArray()
			floor_colors.push_back(Color(0.0, 0.0, 0.0, 0.35))
			floor_colors.push_back(Color(0.0, 0.0, 0.0, 0.35))
			floor_colors.push_back(Color(0.0, 0.0, 0.0, 0.35))
			floor_colors.push_back(Color(0.0, 0.0, 0.0, 0.35))
			var floor_arrays = []
			floor_arrays.resize(ArrayMesh.ARRAY_MAX)
			floor_arrays[ArrayMesh.ARRAY_VERTEX] = floor_vertices
			floor_arrays[ArrayMesh.ARRAY_COLOR] = floor_colors
			array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, floor_arrays)
		
		# Top (+Z)
		var top_vertices = PoolVector2Array()
		top_vertices.push_back(top_left)
		top_vertices.push_back(top_top)
		top_vertices.push_back(top_bottom)
		top_vertices.push_back(top_right)
		var top_colors = PoolColorArray()
		top_colors.push_back(Color(0.0, 0.0, 1.0, 0.3))
		top_colors.push_back(Color(0.0, 0.0, 1.0, 0.3))
		top_colors.push_back(Color(0.0, 0.0, 1.0, 0.3))
		top_colors.push_back(Color(0.0, 0.0, 1.0, 0.3))
		var top_arrays = []
		top_arrays.resize(ArrayMesh.ARRAY_MAX)
		top_arrays[ArrayMesh.ARRAY_VERTEX] = top_vertices
		top_arrays[ArrayMesh.ARRAY_COLOR] = top_colors
		array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, top_arrays)
		
		# Left (+Y)
		var left_vertices = PoolVector2Array()
		left_vertices.push_back(top_left)
		left_vertices.push_back(bottom_left)
		left_vertices.push_back(top_bottom)
		left_vertices.push_back(bottom_bottom)
		var left_colors = PoolColorArray()
		left_colors.push_back(Color(0.0, 1.0, 0.0, 0.3))
		left_colors.push_back(Color(0.0, 1.0, 0.0, 0.3))
		left_colors.push_back(Color(0.0, 1.0, 0.0, 0.3))
		left_colors.push_back(Color(0.0, 1.0, 0.0, 0.3))
		var left_arrays = []
		left_arrays.resize(ArrayMesh.ARRAY_MAX)
		left_arrays[ArrayMesh.ARRAY_VERTEX] = left_vertices
		left_arrays[ArrayMesh.ARRAY_COLOR] = left_colors
		array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, left_arrays)
		
		# Right (+X)
		var right_vertices = PoolVector2Array()
		right_vertices.push_back(top_bottom)
		right_vertices.push_back(bottom_bottom)
		right_vertices.push_back(top_right)
		right_vertices.push_back(bottom_right)
		var right_colors = PoolColorArray()
		right_colors.push_back(Color(1.0, 0.0, 0.0, 0.3))
		right_colors.push_back(Color(1.0, 0.0, 0.0, 0.3))
		right_colors.push_back(Color(1.0, 0.0, 0.0, 0.3))
		right_colors.push_back(Color(1.0, 0.0, 0.0, 0.3))
		var right_arrays = []
		right_arrays.resize(ArrayMesh.ARRAY_MAX)
		right_arrays[ArrayMesh.ARRAY_VERTEX] = right_vertices
		right_arrays[ArrayMesh.ARRAY_COLOR] = right_colors
		array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, right_arrays)
		
		collision_preview_mesh.mesh = array_mesh
		if not collision_preview_mesh.get_parent():
			add_child(collision_preview_mesh)
		collision_preview_mesh.position = Vector2(0.0, -COLLISION_PREVIEW_DRAW_OFFSET)
		collision_preview_mesh.z_index = 128
	
	else: # Remove collision preview
		if collision_preview_mesh != null and weakref(collision_preview_mesh).get_ref():
			collision_preview_mesh.queue_free()
			collision_preview_mesh = null
