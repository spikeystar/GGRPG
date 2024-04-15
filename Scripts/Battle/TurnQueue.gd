extends Node2D

class_name TurnQueue

onready var active_fighter : Fighter

func initialize():
	var fighters = get_fighters()
	active_fighter = get_child(0)
	
func play_turn():
	yield(active_character.play_turn(), "completed")
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
