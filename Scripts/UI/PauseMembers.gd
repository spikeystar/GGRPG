extends Sprite
onready var Cursors = []
var member_index = -1

func _ready():
	Cursors = $Cursors.get_children()

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		pass
		
	if Input.is_action_just_pressed("ui_left"):
		pass

	
	if Input.is_action_just_pressed("ui_select"):
		pass
