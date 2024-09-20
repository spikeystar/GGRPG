extends Node2D

var moving = false

enum TransitionType {
	FADE_TO_BLACK = 0,
}

const TransitionPlayer = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

var target_scene : PackedScene
export(PackedScene) var Garys_House
#export(PackedScene) var Cherry_Trail
#export(PackedScene) var Pivot_Town
#export(PackedScene) var Kugi_Canyon
#export(PackedScene) var Berry_Lake



func _ready():
	
	SceneManager.location = "Gary's House"
	set_location()
	
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("open")
	
	if Music.id != "Overworld" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Overworld"
		Music.music()
	
	
	
func _input(event):
	if SceneManager.location == "Gary's House" and Input.is_action_just_pressed("ui_right") and not moving or SceneManager.location == "Gary's House" and Input.is_action_just_pressed("ui_down") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(190, 327), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Cherry Trail"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Cherry Trail" and Input.is_action_just_pressed("ui_up") and not moving or SceneManager.location == "Cherry Trail" and Input.is_action_just_pressed("ui_left") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(174, 261), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Gary's House"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Cherry Trail" and Input.is_action_just_pressed("ui_right") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(347, 321), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Pivot Town"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Pivot Town" and Input.is_action_just_pressed("ui_left") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(190, 327), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Cherry Trail"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Pivot Town" and Input.is_action_just_pressed("ui_up") and not moving or SceneManager.location == "Pivot Town" and Input.is_action_just_pressed("ui_right") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(378, 202), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Kugi Canyon"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Kugi Canyon" and Input.is_action_just_pressed("ui_left") and not moving or SceneManager.location == "Kugi Canyon" and Input.is_action_just_pressed("ui_down") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(347, 321), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Pivot Town"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Kugi Canyon" and Input.is_action_just_pressed("ui_right") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(458, 205), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Berry Lake"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Berry Lake" and Input.is_action_just_pressed("ui_left") and not moving:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(378, 202), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Kugi Canyon"
		$Location.text = SceneManager.location
		moving = false
		
	
	############## Location Loading ######################
	if SceneManager.location == "Gary's House" and Input.is_action_just_pressed("ui_select") and not moving:
		moving = true
		yield(get_tree().create_timer(0.3), "timeout")
		travel()
	
	
func set_location():
	if SceneManager.location == "Gary's House":
		$Gary.position = Vector2(174, 261)
		
	if SceneManager.location == "Cherry Trail":
		$Gary.position = Vector2(190, 327)
		
	if SceneManager.location == "Pivot Town":
		$Gary.position = Vector2(347, 321)
		
	if SceneManager.location == "Kugi Canyon":
		$Gary.position = Vector2(378, 202)
		
	if SceneManager.location == "Berry Lake":
		$Gary.position = Vector2(458, 205)
		
		
func travel():
	SE.effect("Select")
	SE.effect("Save Star")
	Global.door_name = SceneManager.location
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	if SceneManager.location == "Gary's House":
		target_scene = Garys_House
	#if SceneManager.location == "Cherry Trail":
	#	transition.transition_in(Cherry_Trail, _get_animation_name())
	#if SceneManager.location == "Pivot Town":
	#	transition.transition_in(Pivot_Town, _get_animation_name())
	#if SceneManager.location == "Kugi Canyon":
	#	transition.transition_in(Kugi_Canyon, _get_animation_name())
	#if SceneManager.location == "Berry Lake":
	#	transition.transition_in(Berry_Lake, _get_animation_name())
	transition.transition_in(target_scene, _get_animation_name())
	

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name
