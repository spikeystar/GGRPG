extends Node2D

export(String) var ID = ""
export(int) var e_health
export(int) var e_attack 
export(int) var e_magic
export(int) var e_defense 
export(int) var e_type

export(String) var move1 = ""
export(String) var move2 = ""
export(String) var move3 = ""

func _ready():
	$AnimationPlayer.play("enemy_idle")
	$Cursor.hide()

func focus():
	$Cursor.show()
	$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func attack():
	$AnimationPlayer.play("enemy_attack")
	
func damage():
	$DamageStar.show()
	$AnimationPlayer.play("enemy_damage")
	$DamagePlayer.play("neutral")
	
func death():
	if e_health <= 0:
		$Poof.show()
		$AnimationPlayer.play("enemy_death")
		$PoofPlayer.play("poof")

#func take_damage():
	#e_health = e_health - (fighter_attack_total - e_defense)
