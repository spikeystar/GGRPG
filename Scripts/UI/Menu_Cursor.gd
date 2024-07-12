extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var defend_active = false
var magic_active = false
var up_count : int = 0
var cursor_active = false
var item_active = false
var empty_items = false
var spell_selected = false
signal item_active()
signal magic_active()
signal go_to_Item()

func _process(delta):
	var input := Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_up") and cursor_active:
		flicker_control()
		input.y -= 1
		emit_signal("item_active")
		emit_signal("magic_active")
		if defend_active:
			SE.effect("Move Between")
			up_count += 1
		if magic_active:
			SE.effect("Move Between")
			up_count += 1
	if Input.is_action_just_pressed("ui_down") and cursor_active:
		input.y += 1
		emit_signal("item_active")
		emit_signal("magic_active")
		if defend_active and up_count >-2:
			SE.effect("Move Between")
			up_count -= 1
		if magic_active:
			SE.effect("Move Between")
			up_count -= 1
			
	if Input.is_action_just_pressed("ui_left"):
		emit_signal("magic_active")
			
			
	#if Input.is_action_just_pressed("ui_left"):
		#input.x -= 1
	#if Input.is_action_just_pressed("ui_right"):
		#input.x += 1
	
	if menu_parent is VBoxContainer:
		set_cursor_from_index(cursor_index + input.y)
	elif menu_parent is HBoxContainer:
		set_cursor_from_index(cursor_index + input.x)
	elif menu_parent is GridContainer:
		set_cursor_from_index(cursor_index + input.x + input.y * menu_parent.columns)
	
	if Input.is_action_just_pressed("ui_select") and cursor_active:
		var current_menu_item := get_menu_item_at_index(cursor_index)
		
		if current_menu_item != null:
			if current_menu_item.has_method("cursor_select"):
				current_menu_item.cursor_select()
				
	if Input.is_action_just_pressed("ui_up") and defend_active and up_count == 0 or up_count == 2:
		SE.effect("Move Between")
		emit_signal("go_to_Item")
		up_count = 0
		
	if Input.is_action_just_pressed("ui_up") and magic_active and up_count == 1 and not spell_selected:
		SE.effect("Move Between")
		emit_signal("go_to_Item")
		up_count = 0
		

func get_menu_item_at_index(index : int) -> Control:
	if menu_parent == null:
		return null
	
	if index >= menu_parent.get_child_count() or index < 0:
		return null
	
	return menu_parent.get_child(index) as Control

func set_cursor_from_index(index : int) -> void:
	var menu_item := get_menu_item_at_index(index)
	
	if menu_item == null:
		return
	
	var position = menu_item.rect_global_position
	var size = menu_item.rect_size
	
	rect_global_position = Vector2(position.x, position.y + size.y / 2.0) - (rect_size / 2.0) - cursor_offset
	
	cursor_index = index

func _on_WorldRoot_index_reset():
	if cursor_index != -1:
			cursor_index = -1

func _on_WorldRoot_index_resetzero():
	if cursor_index != 0:
			cursor_index = 0

func _on_WorldRoot_defend_active():
	up_count = 0
	defend_active = true
	cursor_active = true

func _on_WorldRoot_defend_inactive():
	defend_active = false
	cursor_active = false

func _on_WorldRoot_magic_active():
	up_count = 0
	magic_active = true
	cursor_active = true
	spell_selected = false

func _on_WorldRoot_magic_inactive():
	magic_active = false
	cursor_active = true

func _on_WorldRoot_item_active():
	cursor_active = true

func _on_WorldRoot_item_inactive():
	cursor_active = false

func _on_SpellList_spell_chosen():
	spell_selected = true
	cursor_active = false

func _on_SpellList_ally_spell_chosen():
	spell_selected = true
	cursor_active = false

func flicker_control():
	modulate.a = 0
	yield(get_tree().create_timer(0.05), "timeout")
	modulate.a = 1

func _on_WorldRoot_action_ongoing():
	cursor_active = false
