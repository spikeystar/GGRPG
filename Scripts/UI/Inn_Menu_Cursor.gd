extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var menu_name : String
var option_selecting = false
var able = false

signal option_selecting
signal retread

func _ready():
	pass
	#self.modulate.a = 0

func _process(delta):
	var input := Vector2.ZERO
	var current_menu_item := get_menu_item_at_index(cursor_index)
	if option_selecting:
		menu_name = current_menu_item.get_id()
	
	if Input.is_action_just_pressed("ui_up") and cursor_index >0 and option_selecting:
		SE.effect("Move Between")
		input.y -= 1
	if Input.is_action_just_pressed("ui_down") and option_selecting and cursor_index <1:
		SE.effect("Move Between")
		input.y += 1
	#else:
		#input.y += 0
		
	#if Input.is_action_just_pressed("ui_accept") and able or Input.is_action_just_pressed("ui_left") and able:
		#option_selecting = false
		#able = false
		#cursor_index = 0
		#self.modulate.a = 0
		
	#if Input.is_action_just_pressed("ui_select") and able:
		#able = false
		#option_selecting = false
		#self.modulate.a = 0
		#SE.effect("Select")
		
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


func _on_Interaction_option_selecting():
	option_selecting = true
	cursor_index = 0
	self.modulate.a = 1
	yield(get_tree().create_timer(0.2), "timeout")
	able = true

