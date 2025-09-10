extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var cursor_active = false
var down_count = 0
var up_count = 0
var menu_name : String
var member_options = false
var stats_active = false

signal party_selecting
signal switch_selecting
signal show_stats
signal retread

func _process(delta):
	var input := Vector2.ZERO
	var current_menu_item := get_menu_item_at_index(cursor_index)
	menu_name = current_menu_item.get_id()
	
	if Input.is_action_just_pressed("ui_up") and member_options and not Input.is_action_just_pressed("ui_left") and not Input.is_action_just_pressed("ui_right"):
		if up_count == -1:
			SE.effect("Move Between")
			up_count = 0
		
		input.y -= 1
		if down_count >=1:
			down_count -= 1
		
			
	if Input.is_action_just_pressed("ui_down") and down_count <1 and member_options and not Input.is_action_just_pressed("ui_left") and not Input.is_action_just_pressed("ui_right"):
		SE.effect("Move Between")
		input.y += 1
		down_count += 1
		
		if up_count == 0:
			up_count -= 1
		
	else:
		input.y += 0
		
		

		
	if menu_parent is VBoxContainer:
		set_cursor_from_index(cursor_index + input.y)
	elif menu_parent is HBoxContainer:
		set_cursor_from_index(cursor_index + input.x)
	elif menu_parent is GridContainer:
		set_cursor_from_index(cursor_index + input.x + input.y * menu_parent.columns)
	
#	if Input.is_action_just_pressed("ui_select") and cursor_active:
		#var current_menu_item := get_menu_item_at_index(cursor_index)
		
		if current_menu_item != null:
			if current_menu_item.has_method("cursor_select"):
				current_menu_item.cursor_select()
				
		
func _input(event):
	if Input.is_action_just_pressed("ui_accept") and not Input.is_action_just_pressed("ui_select") and member_options or Input.is_action_just_pressed("ui_left") and member_options and not Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_cancel") and member_options and not Input.is_action_just_pressed("ui_select"):
		SE.effect("Cancel")
		self.hide()
		member_options = false
		cursor_index = 0
		down_count = 0
		emit_signal("party_selecting")
		emit_signal("retread")
		
	if Input.is_action_just_pressed("ui_select") and member_options and down_count == 0 and PartyStats.party_members == 1:
		SE.effect("Unable")
		
	if Input.is_action_just_pressed("ui_select") and member_options and down_count == 0 and PartyStats.party_members > 1 and not Input.is_action_just_pressed("ui_left") and not Input.is_action_just_pressed("ui_accept") and not Input.is_action_just_pressed("ui_cancel"):
		SE.effect("Select")
		member_options = false
		cursor_index = 0
		down_count = 0
		emit_signal("switch_selecting")
		
	if Input.is_action_just_pressed("ui_select") and member_options and down_count == 1 and not Input.is_action_just_pressed("ui_left") and not Input.is_action_just_pressed("ui_accept") and not Input.is_action_just_pressed("ui_cancel"):
		SE.effect("Select")
		member_options = false
		cursor_index = 0
		emit_signal("show_stats")
		
		
	if Input.is_action_just_pressed("ui_accept") and stats_active or Input.is_action_just_pressed("ui_left") and stats_active or Input.is_action_just_pressed("ui_cancel") and stats_active:
		SE.effect("Cancel")
		SE.silence("Move Between")
		emit_signal("party_selecting")
		emit_signal("retread")
		stats_active = false

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



