extends Label
onready var Enemies = get_tree().get_root().get_node("WorldRoot/Enemies")

var enemy_selecting = false

func _process(delta):
	if Input.is_action_just_pressed("ui_right") and enemy_selecting:
		text = Enemies.get_name()

func _on_WorldRoot_attack_active():
	enemy_selecting = true

func _on_Enemies_jinx_doll():
	enemy_selecting = false

func _on_Enemies_enemy_chosen():
	enemy_selecting = false
