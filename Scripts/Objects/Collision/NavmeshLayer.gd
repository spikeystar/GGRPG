# This class should be initialized as a child of Navmesh
# The polygon defined will be used as the navmesh.

extends CollisionPolygon2D

export var height: float = 0.0

export var floating = false
export var flowing = false
export var magic = false

var vel : Vector3;
var velocity

func floor_check():
	pass
