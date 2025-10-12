extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)
#onready var defend_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var defend_active = false
var magic_active = false
var up_count : int = 0
var cursor_active = false
var item_active = false
var empty_items = false
var spell_selected = false
var item_stolen = false
signal item_active()
signal magic_active()
signal go_to_Item()

var cursor_ready = true
var menu_name = ""
var item_name = ""
var defend_name = ""
var wimpy = false

export var tutorial : bool



func _process(delta):
	var input := Vector2.ZERO
	var child_count = menu_parent.get_child_count()
	#var defend_count = defend_parent.get_child_count()
	
	if defend_active:
		var defend_selection := get_menu_item_at_index(cursor_index)
		if child_count > 0 and defend_active:
			defend_selection = get_menu_item_at_index(cursor_index)
			
			
		if Input.is_action_just_pressed("ui_select") and cursor_active and cursor_ready and defend_active:
		
			if defend_selection != null:
				if defend_selection.has_method("cursor_select"):
					defend_selection.cursor_select()
			
			
				
	if item_active or magic_active:
		var current_menu_item := get_menu_item_at_index(cursor_index)
		if child_count > 0 and current_menu_item and item_active:
			if current_menu_item.has_method("get_id"):
				item_name = current_menu_item.get_id()
				
	
		if child_count > 0 and current_menu_item and magic_active:
			if current_menu_item.has_method("get_id"):
				menu_name = current_menu_item.get_id()
				

	
	
	
	if Input.is_action_just_pressed("ui_up") and cursor_active and not tutorial:
		#flicker_control()
		input.y -= 1
		emit_signal("item_active")
		emit_signal("magic_active")
		if defend_active:
			if up_count == -1 and item_stolen:
				SE.effect("Unable")
			else:
				flicker_control()
				SE.effect("Move Between")
				up_count += 1
		if magic_active and not up_count == 1 and not item_stolen:
			flicker_control()
			SE.effect("Move Between")
			up_count += 1

		#if magic_active and up_count == 0 and item_stolen:
		#	SE.effect("Unable")
			
		if magic_active and cursor_index == 0 and item_stolen:
			SE.effect("Unable")
		#if item_active and up_count == 0:
			#return
	if Input.is_action_just_pressed("ui_down") and cursor_active and not tutorial:
		input.y += 1
		emit_signal("item_active")
		#emit_signal("magic_active")
		if defend_active and up_count >-2 and not magic_active:
			SE.effect("Move Between")
			up_count -= 1
		if magic_active and not defend_active:
			emit_signal("magic_active")
			SE.effect("Move Between")
			up_count -= 1
			
	if Input.is_action_just_pressed("ui_left") and not tutorial:
		emit_signal("magic_active")
		
	if Input.is_action_just_pressed("ui_right") and defend_active and not wimpy:
		defend_active = false
			
			
	#if Input.is_action_just_pressed("ui_left"):
		#input.x -= 1
	#if Input.is_action_just_pressed("ui_right"):
		#input.x += 1
		
	if menu_parent is VBoxContainer:
		set_cursor_from_index(cursor_index + input.y)
#	if defend_parent is VBoxContainer and defend_active:
		#set_cursor_from_index(cursor_index + input.y)
	elif menu_parent is HBoxContainer:
		set_cursor_from_index(cursor_index + input.x)
	elif menu_parent is GridContainer:
		set_cursor_from_index(cursor_index + input.x + input.y * menu_parent.columns)
	
	

				
	if Input.is_action_just_pressed("ui_up") and defend_active and up_count == 0 or up_count == 2 and not tutorial:
		emit_signal("go_to_Item")
		up_count = 0
		if item_stolen:
			#print("defend")
			SE.effect("Unable")
		else:
			SE.effect("Move Between")
		
	if Input.is_action_just_pressed("ui_up") and magic_active and up_count == 1 and not spell_selected and not tutorial:
		emit_signal("go_to_Item")
		up_count = 0
		if item_stolen:
			#print("magic")
			SE.effect("Unable")
		else:
			SE.effect("Move Between")
		

func get_menu_item_at_index(index : int) -> Control:
	if menu_parent == null:
		return null
		#pass
	
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
	magic_active = false
	item_active = false

func _on_WorldRoot_defend_inactive():
	defend_active = false
	cursor_active = false

func _on_WorldRoot_magic_active():
	up_count = 0
	magic_active = true
	defend_active = false
	item_active = false
	cursor_active = true
	spell_selected = false

func _on_WorldRoot_magic_inactive():
	magic_active = false
	cursor_active = true

func _on_WorldRoot_item_active():
	#up_count = 0
	cursor_active = true
	item_active = true
	#magic_active = false
	#defend_active = false

func _on_WorldRoot_item_inactive():
	cursor_active = false
	item_active = false

func _on_SpellList_spell_chosen():
	spell_selected = true
	cursor_active = false
	magic_active = false

func _on_SpellList_ally_spell_chosen():
	spell_selected = true
	cursor_active = false
	magic_active = false

func flicker_control():
	modulate.a = 0
	#yield(get_tree().create_timer(0.05), "timeout")
	modulate.a = 1

func _on_WorldRoot_action_ongoing():
	cursor_active = false
	
