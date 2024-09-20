extends Node2D

var moving = false

func _ready():
	SceneManager.location = "Gary's House"
	set_location()
	
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
		pass
	
	
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
		
