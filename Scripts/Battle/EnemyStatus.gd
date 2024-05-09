extends Sprite
onready var Enemies = get_tree().get_root().get_node("WorldRoot/Enemies")

var enemy_selecting = false
var poison = false
var stun = false

func _process(delta):
	if Input.is_action_just_pressed("ui_right") and enemy_selecting:
		$Icons/Statuses.hide()
		#var attack_buff = Enemies.get_status()
		#var magic_buff = Enemies.get_status()
		#var defense_buff = Enemies.get_status()
		#var attack_debuff = Enemies.get_status()
		#var magic_debuff = Enemies.get_status()
		#var defense_debuff = Enemies.get_status()
		#poison = Enemies.get_status(poison)
		#stun = Enemies.get_status(stun)
		#if poison:
		#	$Icons/Statuses/Poison.show()
		#if stun:
		#	$Icons/Statuses/Stun.show()

	if Input.is_action_just_pressed("ui_right") and enemy_selecting:
		var type = Enemies.get_type()
		if type == "neutral":
			$Icons/Types/Neutral.show()
			$Icons/Types/Fire.hide()
			$Icons/Types/Water.hide()
			$Icons/Types/Air.hide()
			$Icons/Types/Earth.hide()
		if type == "fire":
			$Icons/Types/Fire.show()
			$Icons/Types/Neutral.hide()
			$Icons/Types/Water.hide()
			$Icons/Types/Air.hide()
			$Icons/Types/Earth.hide()
		if type == "water":
			$Icons/Types/Water.show()
			$Icons/Types/Neutral.hide()
			$Icons/Types/Fire.hide()
			$Icons/Types/Air.hide()
			$Icons/Types/Earth.hide()
		if type == "air":
			$Icons/Types/Air.show()
			$Icons/Types/Neutral.hide()
			$Icons/Types/Fire.hide()
			$Icons/Types/Water.hide()
			$Icons/Types/Earth.hide()
		if type == "earth":
			$Icons/Types/Earth.show()
			$Icons/Types/Neutral.hide()
			$Icons/Types/Fire.hide()
			$Icons/Types/Water.hide()
			$Icons/Types/Air.hide()

func _on_WorldRoot_attack_active():
	enemy_selecting = true

func _on_Enemies_enemy_chosen():
	enemy_selecting = false

func _on_Enemies_jinx_doll():
	enemy_selecting = false
