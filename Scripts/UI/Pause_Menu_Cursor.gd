extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0
var cursor_active = false
var down_count = 0
var menu_name : String
var main_active = true
var stats_active = false
var items_empty = false
var trinkets_empty = false
var key_empty = false
var switching = false
var ongoing = false
var members = false
var ready = true

signal party_selecting
signal item_selecting
signal trinket_selecting
signal enemy_selecting
signal key_selecting
signal retread
signal mini_retread

func _process(delta):
	var input := Vector2.ZERO
	var current_menu_item := get_menu_item_at_index(cursor_index)
	
	menu_name = current_menu_item.get_id()

	if Input.is_action_just_pressed("ui_up") and main_active and not Input.is_action_just_pressed("ui_right"):
		input.y -= 1
		if down_count >=1:
			SE.effect("Move Between")
			down_count -= 1
	if Input.is_action_just_pressed("ui_down") and down_count <5 and main_active and not Input.is_action_just_pressed("ui_right"):
		SE.effect("Move Between")
		input.y += 1
		down_count += 1	
	else:
		input.y += 0
		
	if Input.is_action_just_pressed("ui_right") and main_active and menu_name == "Party":
		SE.effect("Move Between")
		self.hide()
		main_active = false
		stats_active = false
		emit_signal("party_selecting")
		
	if Input.is_action_just_pressed("ui_right") and main_active and menu_name == "Items" and not items_empty:
		SE.effect("Move Between")
		self.hide()
		main_active = false
		emit_signal("item_selecting")
		
	if Input.is_action_just_pressed("ui_right")and main_active and menu_name == "Trinkets" and not trinkets_empty:
		SE.effect("Move Between")
		self.hide()
		main_active = false
		emit_signal("trinket_selecting")
		
	if Input.is_action_just_pressed("ui_right")and main_active and menu_name == "Enemies":
		if Party.EnemyList.size() > 0:
			SE.effect("Move Between")
			self.hide()
			main_active = false
			emit_signal("enemy_selecting")
		
	if Input.is_action_just_pressed("ui_right") and main_active and menu_name == "Key" and not key_empty:
		SE.effect("Move Between")
		self.hide()
		main_active = false
		emit_signal("key_selecting")
		
	if Input.is_action_just_pressed("ui_accept") and not main_active and not stats_active and not ongoing or Input.is_action_just_pressed("ui_cancel") and not main_active and not stats_active and not ongoing:
		#self.show()
		#main_active = true
		#emit_signal("retread")
		
		if switching:
			SE.effect("Cancel")
			switching = false
			
			self.hide()
			emit_signal("mini_retread")
			
		if members:
			SE.effect("Cancel")
			self.hide()
			emit_signal("mini_retread")
			members = false
			
		#else:
			#SE.silence("Move Between")
			#SE.effect("Cancel")
			
			#self.show()
			#main_active = true
			#members = false
			#emit_signal("retread")
		
		
	if Input.is_action_just_pressed("ui_accept") and not main_active and stats_active or Input.is_action_just_pressed("ui_cancel") and not main_active and stats_active:
		SE.effect("Move Between")
		self.hide()
		emit_signal("mini_retread")
		
		
			
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

func _on_MemberOptionsCursor_show_stats():
	stats_active = true
	main_active = false

func _on_MemberOptionsCursor_retread():
	stats_active = false
	main_active = false
	members = false

func _on_ItemMenuCursor_retread():
	self.show()
	self.modulate.a = 0
	yield(get_tree().create_timer(0.05), "timeout")
	self.modulate.a = 1
	main_active = true

func _on_ItemInventoryBox_heal_item_chosen():
	cursor_index = 0

func _on_ItemInventoryBox_return_to_item():
	cursor_index = 1
	yield(get_tree().create_timer(0.4), "timeout")
	ongoing = false

func _on_TrinketsCursor_retread():
	self.show()
	self.modulate.a = 0
	yield(get_tree().create_timer(0.05), "timeout")
	self.modulate.a = 1
	main_active = true

func _on_TrinketsInventory_trinket_chosen():
	cursor_index = 0

func _on_TrinketsInventory_return_to_trinkets():
	cursor_index = 2
	yield(get_tree().create_timer(0.3), "timeout")
	ongoing = false

func _on_KeyCursor_retread():
	self.show()
	self.modulate.a = 0
	yield(get_tree().create_timer(0.05), "timeout")
	self.modulate.a = 1
	main_active = true

func _on_ItemInventoryBox_empty_items():
	items_empty = true
	self.show()
	#self.modulate.a = 0
	#yield(get_tree().create_timer(0.05), "timeout")
	self.modulate.a = 1
	main_active = true

func _on_TrinketsInventory_empty_trinkets():
	trinkets_empty = true

func _on_KeyInventory_empty_key():
	key_empty = true

func _on_EnemiesCursor_retread():
	self.show()
	self.modulate.a = 0
	yield(get_tree().create_timer(0.05), "timeout")
	self.modulate.a = 1
	main_active = true

func _on_Members_main_retread():
	cursor_index = 0
	down_count = 0
	self.show()
	main_active = true
	members = false

func _on_MemberOptionsCursor_switch_selecting():
	switching = true

func _on_Members_switched():
	switching = false
	members = false
	

func _on_ItemInventoryBox_ongoing():
	ongoing = true

func _on_TrinketsInventory_ongoing():
	ongoing = true

func _on_Members_member_options():
	members = true
