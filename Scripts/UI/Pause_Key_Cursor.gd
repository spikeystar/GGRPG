extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var key_selecting = false

signal key_selecting
signal retread

func _ready():
	self.modulate.a = 0

func _process(delta):
	var input := Vector2.ZERO
	var current_menu_item := get_menu_item_at_index(cursor_index)
	
	if Input.is_action_just_pressed("ui_up") and cursor_index >0 and key_selecting:
		input.y -= 1
		self.modulate.a = 0
		yield(get_tree().create_timer(0.01), "timeout")
		self.modulate.a = 1
	if Input.is_action_just_pressed("ui_down") and key_selecting:
		input.y += 1
		self.modulate.a = 0
		yield(get_tree().create_timer(0.01), "timeout")
		self.modulate.a = 1
	else:
		input.y += 0
		
	if Input.is_action_just_pressed("ui_accept") and key_selecting or Input.is_action_just_pressed("ui_left") and key_selecting:
		SE.effect("Move Between")
		key_selecting = false
		self.modulate.a = 0
		emit_signal("retread")
		cursor_index = 0
		
		
	if menu_parent is VBoxContainer:
		set_cursor_from_index(cursor_index + input.y)
	elif menu_parent is HBoxContainer:
		set_cursor_from_index(cursor_index + input.x)
	elif menu_parent is GridContainer:
		set_cursor_from_index(cursor_index + input.x + input.y * menu_parent.columns)
	
#	if Input.is_action_just_pressed("ui_select") and cursor_active:
		#var current_menu_item := get_menu_item_at_index(cursor_index)
		
		#if current_menu_item != null:
			#if current_menu_item.has_method("cursor_select"):
				#current_menu_item.cursor_select()
				
		

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

func _on_MenuCursor_key_selecting():
	self.modulate.a = 1
	set_cursor_from_index(0)
	key_selecting = true
