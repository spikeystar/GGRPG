extends Node2D

export(String) var ID = ""
export(int) var e_health
export(int) var e_attack 
export(int) var e_magic
export(int) var e_defense 
export(int) var e_type
export(PackedScene) var TEXT_DAMAGE: PackedScene = null
export(PackedScene) var TEXT_HEAL: PackedScene = null
var current_e_health : int 

export(String) var move1 = ""
export(String) var move2 = ""
export(String) var move3 = ""

signal enemy_dead

func _ready():
	$AnimationPlayer.play("enemy_idle")
	$Cursor.hide()
	current_e_health = e_health

func focus():
	$Cursor.show()
	$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func attack():
	$AnimationPlayer.play("enemy_attack")
	
func damage():
	#var damage = 50
	#current_e_health = e_health - damage
	$DamageStar.show()
	$AnimationPlayer.play("enemy_damage")
	$AnimationPlayer.playback_speed = 0.7
	$DamagePlayer.play("neutral")
	#$DamageText.show()
	#$DamageText/AnimationPlayer.play("Display")
	#damage_text(damage)
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("enemy_idle")
	$AnimationPlayer.playback_speed = 0.5
	#if e_health <= 0:
		#death()
	#else:
		#$AnimationPlayer.play("enemy_idle")
		
func get_e_defense():
	return e_defense
		
func health_check():
	return current_e_health
	
func health_set(damage: int):
	current_e_health = current_e_health - damage
	
func death():
		$AnimationPlayer.play("enemy_death")
		$AnimationPlayer.playback_speed = 0.8
		$Poof.show()
		$PoofPlayer.play("poof")
		#yield(get_tree().create_timer(1), "timeout")
		#self.remove_child(self)

func get_position(enemy_position: Vector2 = global_position):
	return enemy_position
	
func text(TEXT: PackedScene, text_position: Vector2 = global_position):
	if TEXT:
		var text = TEXT.instance()
		get_tree().current_scene.add_child(text)
		text.global_position = text_position + Vector2(4, -44)
		return text
		
func damage_text(damage: int):
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(damage)
	
#func take_damage():
	#e_health = e_health - (fighter_attack_total - e_defense)
