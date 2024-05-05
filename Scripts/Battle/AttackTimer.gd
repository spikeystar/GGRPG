extends Node2D

onready var timer = $Timer
var max_hits : int = 0
var Fighters : Node2D
var fighter_name : String
var max_time : int
var active = false

signal attack_bonus

func _ready():
	Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")
	fighter_name = Fighters.get_f_name()
	
func _process(delta):
	var hit_time = get_time()
	var gary_time1 = hit_time >= 1.75 and hit_time <= 2.2
	var gary_time2 = hit_time >= 1.2 and hit_time <= 1.55
	var gary_time3 = hit_time >= 0.2 and hit_time <= 0.45
	var jacques_time1 = hit_time >= 2.25 and hit_time <= 2.5
	var jacques_time2 = hit_time >= 0.2 and hit_time <= 0.5
	var irina_time1 = hit_time >= 0.2 and hit_time <= 0.45
	if Input.is_action_just_pressed("ui_select") and active:
		print(hit_time)
	if Input.is_action_just_pressed("ui_select") and active and fighter_name == "gary" and gary_time1:
		max_hits += 1
	if Input.is_action_just_pressed("ui_select") and active and fighter_name == "gary" and gary_time2:
		max_hits += 1
	if Input.is_action_just_pressed("ui_select") and active and fighter_name == "gary" and gary_time3:
		max_hits += 1
	if Input.is_action_just_pressed("ui_select") and active and fighter_name == "jacques" and jacques_time1:
		max_hits += 1
	if Input.is_action_just_pressed("ui_select") and active and fighter_name == "jacques" and jacques_time2:
		max_hits += 1
	if Input.is_action_just_pressed("ui_select") and active and fighter_name == "irina" and irina_time1:
		max_hits += 1
		
func get_time():
	var current_time : float = timer.time_left
	return current_time
	
func _on_WorldRoot_start_attack_timer():
	fighter_name = Fighters.get_f_name()
	if fighter_name == "gary":
		timer.wait_time = 2.4
	if fighter_name == "jacques":
		timer.wait_time = 2.5
	if fighter_name == "irina":
		timer.wait_time = 1.3
	timer.start()
	active = true

func _on_Timer_timeout():
	fighter_name = Fighters.get_f_name()
	active = false
	print(fighter_name)
	print(max_hits)
	if fighter_name == "gary" and max_hits ==3:
		emit_signal("attack_bonus")
		max_hits = 0
	elif fighter_name == "jacques" and max_hits ==2:
		emit_signal("attack_bonus")
		max_hits = 0
	elif fighter_name == "irina" and max_hits ==1:
		emit_signal("attack_bonus")
		max_hits = 0
	else:
		print("fail")
		max_hits = 0
		
