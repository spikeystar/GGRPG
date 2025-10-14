# This class is a container for NavmeshLayers.
# The Navmesh defines where the player can walk in the scene.
# Each NavmeshLayer has its own height, which the player must jump to access.

extends Area2D

const layer_script = preload("res://Scripts/Objects/Collision/FloorSetter.gd")

export var height = 0

export var floating = false
export var flowing = false

var vel : Vector3;
var velocity

const MARGIN : int = 16;

var motion_root
var layers : Array = []

func print_tree(node = null, indent = 0):
	if node == null:
		node = get_tree().root

	var indentation = ""
	for i in range(indent):
		indentation += "  "
	
	print(indentation + node.name)
	
	for child in node.get_children():
		print_tree(child, indent + 1)

func _ready():
	# Grabbing all floor polygons
	var polygons = []
	for child in get_children():
		if child is CollisionPolygon2D:
			if child.has_method("floor_check"):
				child.position.y += child.height
			
			var transformed_polygon = child.transform.xform(child.polygon)
			child.transform = Transform2D.IDENTITY
			child.polygon = transformed_polygon
			polygons.append(child.polygon)
			
			var layerBody = StaticBody2D.new()
			remove_child(child)
			layerBody.add_child(child)
			get_parent().call_deferred("add_child", layerBody)
			layers.append(layerBody)

			var area_polygon = CollisionPolygon2D.new()
			area_polygon.polygon = transformed_polygon
			area_polygon.name = child.name
			area_polygon.visible = false
			
			var area_copy = Area2D.new()
			area_copy.visible = false
			area_copy.set_script(layer_script)
			area_copy.set("height", child.height)
			area_copy.set("floating", child.floating)
			area_copy.set("flowing", child.flowing)
			get_parent().call_deferred("add_child", area_copy)
			area_copy.add_child(area_polygon)

	# Polygons to remove will hold the actual polygons
	var polygons_to_remove := []
	# Index to remove is a dictionary so that searching is faster
	var index_to_remove := {}

	while true:
		# Clear the polygons to remove
		polygons_to_remove = []
		index_to_remove = {}

		# Start looping
		for i in polygons.size():
			# Skip if the polygon is due to remove
			if index_to_remove.get(i, false) == true:
				continue

			var a = polygons[i]

			# Loop from the start of the array to
			# the current polygon
			for j in i:
				# Skip if the polygon is due to remove
				if index_to_remove.get(j, false) == true:
					continue

				var b = polygons[j]
				var merged_polygons = Geometry.merge_polygons_2d(a, b)

				# The polygons dind't merge so skip to the next loop
				if merged_polygons.size() != 1:
					continue

				# Replace the polygon with the merged one
				polygons[j] = merged_polygons[0]

				# Mark to remove the already merged polygon
				polygons_to_remove.append(a)
				index_to_remove[i] = true
				break

		# There is no polygon to remove so we finished
		if polygons_to_remove.size() == 0:
			break

		# Remove the polygons marked to be removed
		for polygon in polygons_to_remove:
			var index = polygons.find(polygon)
			polygons.pop_at(index)
#
#
	var collBody = StaticBody2D.new()
	get_parent().call_deferred("add_child", collBody)

	# Each polygon should be a separate island
	for polygon in polygons:
		# Getting the bounds of all the polygons
		var min_x = 10000
		var min_y = 10000
		var max_x = -10000
		var max_y = -10000
		for point in polygon:
			min_x = min(min_x, point.x)
			min_y = min(min_y, point.y)
			max_x = max(max_x, point.x)
			max_y = max(max_y, point.y)

		min_x -= MARGIN
		max_x += MARGIN
		min_y -= MARGIN
		max_y += MARGIN

		var rectangle_polygon_left = [
			Vector2(min_x, min_y),
			Vector2((max_x + min_x)/2, min_y),
			Vector2((max_x + min_x)/2, max_y),
			Vector2(min_x, max_y)
		]
		var rectangle_polygon_right = [
			Vector2((max_x + min_x)/2, min_y),
			Vector2(max_x, min_y),
			Vector2(max_x, max_y),
			Vector2((max_x + min_x)/2, max_y)
		]

		var clips = Geometry.clip_polygons_2d(rectangle_polygon_left, polygon)
		clips.append_array(Geometry.clip_polygons_2d(rectangle_polygon_right, polygon))

		for clip in clips:
			var pol_clip = CollisionPolygon2D.new()
			pol_clip.name = "PlayerBoundsPolygon"
			pol_clip.polygon = clip
			collBody.add_child(pol_clip)
	
	# Prevent spawn locations being messed up before _physics_process runs.
	var motion_root = PlayerManager.player_motion_root
	if motion_root:
		for layer in layers:
			motion_root.add_collision_exception_with(layer)
			
	PlayerManager.notify_navmesh_ready()
	
	yield(get_tree().create_timer(0.01), "timeout")
	if SceneManager.SceneEnemies.size() > 0:	
		for x in range (SceneManager.SceneEnemies.size()):
			for layer in layers:
				SceneManager.SceneEnemies[x].motion_root.add_collision_exception_with(layer)
			
	
	#PlayerManager.notify_navmesh_ready()

func _physics_process(delta):
	if not motion_root:
		# Getting gary. Pretty stupid way to do it. But gary is spawned at runtime...
		motion_root = PlayerManager.player_motion_root

	if motion_root:
		var player_z = motion_root.pos_z

		for layer in layers:
			if layer.get_child(0).height <= player_z:
				motion_root.add_collision_exception_with(layer)
			else:
				motion_root.remove_collision_exception_with(layer)
				
				
	if SceneManager.SceneEnemies.size() > 0:	
		for x in range (SceneManager.SceneEnemies.size()):
			
			var player_z = SceneManager.SceneEnemies[x].motion_root.pos_z
			for layer in layers:
				if layer.get_child(0).height <= player_z:
					SceneManager.SceneEnemies[x].motion_root.add_collision_exception_with(layer)
				else:
					SceneManager.SceneEnemies[x].motion_root.remove_collision_exception_with(layer)
				
		

