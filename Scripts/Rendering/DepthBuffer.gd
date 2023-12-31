tool
extends Node2D

#---------#
# Imports #
#---------#

const depth_buffer_object_shader = preload("res://Scripts/Rendering/DepthBufferObject.gdshader")

#------------#
# Properties #
#------------#

const DEPTH_EDGE_BUFFER = 600.0

var depth_camera: Camera
var depth_viewport: Viewport
var depth_root: Spatial
var depth_viewport_container: ViewportContainer
var parent_viewport: Viewport
var texture_duplicates = {}
var viewport_size: Vector2 = Vector2(1024, 600)

#----------------#
# Node Lifecycle #
#----------------#

func _init():
	z_index = 1
	depth_viewport_container = ViewportContainer.new()
	depth_viewport_container.name = "DepthViewportContainer"
	depth_viewport_container.material = CanvasItemMaterial.new()
	depth_viewport_container.material.blend_mode = CanvasItemMaterial.BLEND_MODE_PREMULT_ALPHA
	
	depth_viewport = Viewport.new()
	depth_viewport.name = "DepthViewport"
	depth_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	depth_viewport.transparent_bg = true
	depth_viewport.own_world = true
	depth_viewport.world = World.new()
	depth_viewport.world.environment = Environment.new()
	depth_viewport.world.environment.background_mode = Environment.BG_COLOR
	depth_viewport.world.environment.background_color = Color(0, 0, 0, 1)
	
	depth_root = Spatial.new()
	
	depth_camera = Camera.new()
	depth_camera.current = true
	depth_camera.translation.z = -10
	depth_camera.rotation_degrees.y = 180
	depth_camera.rotation_degrees.z = 180
	depth_camera.size = 1000
	depth_camera.far = 1000
	depth_camera.projection = Camera.PROJECTION_ORTHOGONAL
	

func _ready():
	add_child(depth_viewport_container)
	depth_viewport_container.add_child(depth_viewport)
	depth_viewport.add_child(depth_root)
	depth_root.add_child(depth_camera)
	
	parent_viewport = get_viewport()
	parent_viewport.connect("size_changed", self, "_on_parent_viewport_size_changed")
	_set_viewport_size(parent_viewport.size)
	
	var canvas_scale = parent_viewport.canvas_transform.get_scale()
	var canvas_origin = parent_viewport.canvas_transform.get_origin()
	depth_camera.translation = Vector3(
		(-canvas_origin.x + (viewport_size.x / 2.0)) * (1.0 / canvas_scale.x),
		(-canvas_origin.y + (viewport_size.y / 2.0)) * (1.0 / canvas_scale.y),
		(-canvas_origin.y - DEPTH_EDGE_BUFFER) * (1.0 / canvas_scale.y)
	)
	
func _process(delta):
	if not parent_viewport:
		return
	var parent_canvas_scale_inversed = Vector2(1.0, 1.0) / parent_viewport.canvas_transform.get_scale()
	global_position = -parent_viewport.canvas_transform.origin * parent_canvas_scale_inversed
	global_scale = parent_canvas_scale_inversed
	var canvas_scale = parent_viewport.canvas_transform.get_scale()
	var canvas_origin = parent_viewport.canvas_transform.get_origin()
	depth_camera.translation = Vector3(
		(-canvas_origin.x + (viewport_size.x / 2.0)) * (1.0 / canvas_scale.x),
		(-canvas_origin.y + (viewport_size.y / 2.0)) * (1.0 / canvas_scale.y),
		(-canvas_origin.y - DEPTH_EDGE_BUFFER) * (1.0 / canvas_scale.y)
	)

#----------------#
# Public Methods #
#----------------#

func add_depth_test_mesh(
	vertices: PoolVector2Array,
	uvs: PoolVector2Array,
	depth_test: PoolRealArray,
	depth_range: Vector2,
	texture: Texture,
	mesh_position: Vector2
):
	if depth_viewport:
		var array_mesh = Mesh.new()
		var arrays = []
		arrays.resize(ArrayMesh.ARRAY_MAX)
		var vertices_3d = PoolVector3Array()
		var colors = PoolColorArray()
		for i in vertices.size():
			var vertex = vertices[i]
			var depth = depth_range[0] + (depth_range[1] - depth_range[0]) * depth_test[i]
			vertices_3d.push_back(Vector3(vertex.x, vertex.y, depth))
		arrays[ArrayMesh.ARRAY_VERTEX] = vertices_3d
		arrays[ArrayMesh.ARRAY_TEX_UV] = uvs
		array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, arrays)
		var mesh_instance = MeshInstance.new()
		mesh_instance.name = "DepthTestMeshInstance"
		mesh_instance.mesh = array_mesh
		depth_root.add_child(mesh_instance)
		mesh_instance.global_translation = Vector3(mesh_position.x , mesh_position.y, 0.0)
		mesh_instance.material_override = ShaderMaterial.new()
		mesh_instance.material_override.shader = depth_buffer_object_shader
		mesh_instance.material_override.set_shader_param("depth_edge_buffer", DEPTH_EDGE_BUFFER)
		mesh_instance.material_override.set_shader_param("sprite_texture_sampler", _create_texture_duplicate(texture))
		
		return weakref(mesh_instance)
	else:
		return weakref(null)

func remove_depth_test_mesh(mesh_weakref):
	if not mesh_weakref:
		return
	var mesh = mesh_weakref.get_ref()
	if mesh:
		var texture = mesh.material_override.get_shader_param("sprite_texture_sampler")
		_remove_duplicate_texture(texture)
		mesh.queue_free()

func notify_camera_changed():
	if parent_viewport:
		_set_viewport_size(parent_viewport.size)

#-----------------#
# Private Methods #
#-----------------#

func _create_texture_duplicate(texture: Texture):
	if texture and texture.resource_path:
		if texture_duplicates.has(texture.resource_path):
			texture_duplicates[texture.resource_path].users += 1
		else:
			var texture_duplicate = texture.duplicate()
			texture_duplicate.resource_path = texture.resource_path + '_DEPTH_BUFFER'
			texture_duplicates[texture.resource_path] = {
				"users": 1,
				"texture": texture_duplicate
			}
		return texture_duplicates[texture.resource_path].texture
	return texture

func _remove_duplicate_texture(texture: Texture):
	if not texture:
		return
	var resource_path = texture.resource_path.replace("_DEPTH_BUFFER", "")
	if texture.resource_path and texture_duplicates.has(texture.resource_path):
		texture_duplicates[texture.resource_path].users -= 1
		if texture_duplicates[texture.resource_path].users <= 0:
			texture_duplicates.erase(texture.resource_path)

func _on_parent_viewport_size_changed():
	_set_viewport_size(parent_viewport.size)

func _set_viewport_size(size: Vector2):
	viewport_size = size
	depth_viewport_container.rect_size = size
	depth_viewport.size = size
	depth_camera.size = size.y * (1.0 / parent_viewport.canvas_transform.get_scale().y)
	depth_camera.far = DEPTH_EDGE_BUFFER + DEPTH_EDGE_BUFFER + size.y
