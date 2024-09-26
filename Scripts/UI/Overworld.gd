extends Node2D

var moving = false
var ready = false

enum TransitionType {
	FADE_TO_BLACK = 0,
}

const TransitionPlayer = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

var Garys_House = "res://Gary_sHouse.tscn"
var Cherry_Trail = "res://Areas/Cherry Trail/Cherry_Trail_3.tscn"
var Pivot_Town = "res://Areas/Pivot Town/Pivot_Town_1.tscn"
var Kugi_Canyon = "res://Areas/Kugi Canyon/Kugi Canyon 7.tscn"
var Berry_Lake = "res://Areas/Berry Lake/Berry Lake 8.tscn"



func _ready():
	if not SceneManager.overworld:
		self.queue_free()
	
	$Location.text = SceneManager.location
	set_location()
	
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("open")
	ready = true
	
	if Music.id != "Overworld" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Overworld"
		Music.music()
	
	
	
func _input(event):
	if SceneManager.location == "Gary's House" and Input.is_action_just_pressed("ui_right") and not moving and EventManager.Cherry_Trail or SceneManager.location == "Gary's House" and Input.is_action_just_pressed("ui_down") and not moving and EventManager.Cherry_Trail:
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
		
	if SceneManager.location == "Cherry Trail" and Input.is_action_just_pressed("ui_right") and not moving and EventManager.Pivot_Town:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(347, 321), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Pivot Town"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Pivot Town" and Input.is_action_just_pressed("ui_left") and not moving and EventManager.Cherry_Trail:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(190, 327), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Cherry Trail"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Pivot Town" and Input.is_action_just_pressed("ui_up") and not moving and EventManager.Kugi_Canyon or SceneManager.location == "Pivot Town" and Input.is_action_just_pressed("ui_right") and not moving and EventManager.Kugi_Canyon:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(378, 202), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Kugi Canyon"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Kugi Canyon" and Input.is_action_just_pressed("ui_left") and not moving and EventManager.Pivot_Town or SceneManager.location == "Kugi Canyon" and Input.is_action_just_pressed("ui_down") and not moving and EventManager.Pivot_Town:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(347, 321), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Pivot Town"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Kugi Canyon" and Input.is_action_just_pressed("ui_right") and not moving and EventManager.Berry_Lake:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(458, 205), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Berry Lake"
		$Location.text = SceneManager.location
		moving = false
		
	if SceneManager.location == "Berry Lake" and Input.is_action_just_pressed("ui_left") and not moving and EventManager.Kugi_Canyon:
		SE.effect("Move Between")
		moving = true
		var tween = create_tween()
		tween.tween_property($Gary, "position", Vector2(378, 202), 0.5)
		yield(tween, "finished")
		SceneManager.location = "Kugi Canyon"
		$Location.text = SceneManager.location
		moving = false
		
	
	############## Location Loading ######################
	if Input.is_action_just_pressed("ui_select") and not moving and ready:
		moving = true
		SE.effect("Select")
		SE.effect("Save Star")
		yield(get_tree().create_timer(0.3), "timeout")
		travel()
	
	
func set_location():
	if EventManager.Cherry_Trail:
		$Cherry_Trail.show()
		
	if EventManager.Pivot_Town:
		$Pivot_Town.show()
		
	if EventManager.Kugi_Canyon:
		$Kugi_Canyon.show()
		
	if EventManager.Berry_Lake:
		$Berry_Lake.show()
	
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
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	Global.door_name = SceneManager.location
	if SceneManager.location == "Gary's House":
		get_tree().paused = false
		transition.transition_in(Garys_House, _get_animation_name())
		yield(get_tree().create_timer(1), "timeout")
		self.queue_free()
	if SceneManager.location == "Cherry Trail":
		get_tree().paused = false
		transition.transition_in(Cherry_Trail, _get_animation_name())
		yield(get_tree().create_timer(1), "timeout")
		self.queue_free()
	if SceneManager.location == "Pivot Town":
		get_tree().paused = false
		transition.transition_in(Pivot_Town, _get_animation_name())
		yield(get_tree().create_timer(0.8), "timeout")
		self.queue_free()
	if SceneManager.location == "Kugi Canyon":
		get_tree().paused = false
		transition.transition_in(Kugi_Canyon, _get_animation_name())
		yield(get_tree().create_timer(0.8), "timeout")
		self.queue_free()
	if SceneManager.location == "Berry Lake":
		get_tree().paused = false
		transition.transition_in(Berry_Lake, _get_animation_name())
		yield(get_tree().create_timer(1), "timeout")
		self.queue_free()
	

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name
