extends Area2D


var player_height

var piece_height = 10

export var piece_id : int

var able = false
var pressed = false

signal puzzle_solved

func _ready():
	if EventManager.circus_puzzle:
		able = false
		pressed = false
		$Sprite.global_position.y = $Sprite.global_position.y + 2000
		
	if not EventManager.circus_puzzle:
		$Sprite2.global_position.y = $Sprite2.global_position.y + 2000
	




func _process(delta):
	player_height = int(PlayerManager.player_motion_root.pos_z)
	
	if able and player_height == piece_height and not pressed:
		able = false
		pressed = true
		SE.effect("Pressed")
		$CollidableBox.height = 5
		$Sprite.global_position.y = ($Sprite.global_position.y + 2000)
		$Sprite2.global_position.y = ($Sprite.global_position.y - 2000)
	
		
		yield(get_tree().create_timer(0.5), "timeout")
		puzzle_check()
	
	
	if SceneManager.win and pressed:
		pressed = false
		$Sprite.global_position.y = ($Sprite.global_position.y - 2000)
		$Sprite2.global_position.y = ($Sprite2.global_position.y + 2000) 
		SE.effect("Pressed")
		$CollidableBox.height = 10
	
func puzzle_check():
	if piece_id == 0:
		SceneManager.counter = 1
		return
		
	if piece_id == (SceneManager.counter + 1):
		SceneManager.counter += 1
		
	if piece_id == 7 and SceneManager.counter == 7:
		yield(get_tree().create_timer(0.5), "timeout")
		SE.effect("Win")
		yield(get_tree().create_timer(0.5), "timeout")
		emit_signal("puzzle_solved")
		
	if piece_id != (SceneManager.counter) and piece_id != 0:
		SceneManager.counter = 0
		SE.effect("Fail")
		yield(get_tree().create_timer(1), "timeout")
		SceneManager.win = true
		yield(get_tree().create_timer(0.5), "timeout")
		SceneManager.win = false
		pressed = false
		able = false


func _on_Puzzle_Piece_body_entered(body):
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not EventManager.circus_puzzle:
		able = true


func _on_Puzzle_Piece_body_exited(body):
	able = false
