extends Label

var enemy_selecting = false
var enemy_name : String

func _process(delta):
	text = enemy_name
	#if Input.is_action_just_pressed("ui_right") and enemy_selecting:
		#text = enemy_name
		
	#if Input.is_action_just_pressed("ui_left") and enemy_selecting:
		#text = enemy_name

func _on_WorldRoot_attack_active():
	enemy_selecting = true

func _on_Enemies_jinx_doll():
	enemy_selecting = false

func _on_Enemies_enemy_chosen():
	enemy_selecting = false
