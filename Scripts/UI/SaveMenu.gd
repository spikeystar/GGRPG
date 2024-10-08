extends Node2D

#onready var player_instance = PlayerManager.player_instance
#var save_path = "res://save.dat"
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

var ongoing = false
var able = true

var save_path : String
var base_path = "user://save.dat"
var save_name : int
var save1 = false
var save2 = false
var save3 = false

var save1_location : String
var save1_level : String
var save1_frame : int
var save1_js : int

var save2_location : String
var save2_level : String
var save2_frame : int
var save2_js : int

var save3_location : String
var save3_level : String
var save3_frame : int
var save3_js : int

var data = {
		"save1" : save1,
		"save1_location" : save1_location,
		"save1_level" : save1_level,
		"save1_frame" : save1_frame,
		"save1_js" : save1_js,
		"save2" : save2,
		"save2_location" : save2_location,
		"save2_level" : save2_level,
		"save2_frame" : save2_frame,
		"save2_js" : save2_js,
		"save3" : save3,
		"save3_location" : save3_location,
		"save3_level" : save3_level,
		"save3_frame" : save3_frame,
		"save3_js" : save3_js,
		
		"location" : SceneManager.location,
		"door_name" : Global.door_name,
		"jewel_seeds" : Party.jewel_seeds,
		"marbles" : Party.marbles,
		"Tutorial" : Party.Tutorial,
		"Inventory" : Party.Inventory,
		"Storage" : Party.Storage,
		"Trinkets" : Party.Trinkets,
		"KeyItems" : Party.KeyItems,
		"EnemyList" : Party.EnemyList,
		"Gary_Spells" : Party.Gary_Spells,
		"Jacques_Spells" : Party.Jacques_Spells,
		"Irina_Spells" : Party.Irina_Spells,
		"Suzy_Spells" : Party.Suzy_Spells,
		"Damien_Spells" : Party.Damien_Spells,
		"Tom" : Shops.Tom,
		
		"party_members" : PartyStats.party_members,
		"party_level" : PartyStats.party_level,
		"gary_id" : PartyStats.gary_id,
		"jacques_id" : PartyStats.jacques_id,
		"irina_id" : PartyStats.irina_id,
		"suzy_id" : PartyStats.suzy_id,
		"damien_id" : PartyStats.damien_id,
		"gary_trinket" : PartyStats.gary_trinket,
		"jacques_trinket" : PartyStats.jacques_trinket,
		"irina_trinket" : PartyStats.irina_trinket,
		"suzy_trinket" : PartyStats.suzy_trinket,
		"damien_trinket" : PartyStats.damien_trinket,
		"gary_current_health" : PartyStats.gary_current_health,
		"jacques_current_health" : PartyStats.jacques_current_health,
		"irina_current_health" : PartyStats.irina_current_health,
		"suzy_current_health" : PartyStats.suzy_current_health,
		"damien_current_health" : PartyStats.damien_current_health,
		"party_sp" : PartyStats.party_sp,
		"party_max_sp" : PartyStats.party_max_sp,
		"party_exp" : PartyStats.party_exp,
		"next_level" : PartyStats.next_level,
		"new_spell_2" : PartyStats.new_spell_2,
		
		"new_file" : EventManager.new_file,
		"first_save" : EventManager.first_save,
		
		"Cherry_Trail" : EventManager.Cherry_Trail,
		"Pivot_Town" : EventManager.Pivot_Town,
		"Kugi_Canyon" : EventManager.Kugi_Canyon,
		"Berry_Lake" : EventManager.Berry_Lake,
		
		"Michael_Meetup_CS" : EventManager.Michael_Meetup_CS,
		"Tindrum" : EventManager.Tindrum,
		"Jacques_Meetup_CS" : EventManager.Jacques_Meetup_CS,
		"Edgar_Tea_CS" : EventManager.Edgar_Tea_CS,
		"kugi_canyon_extra" : EventManager.kugi_canyon_extra,
		"Saguarotel_Intro" : EventManager.Saguarotel_Intro,
		"Saguarotel" : EventManager.Saguarotel,
		"Reeler" : EventManager.Reeler,
		"BL_Inn_CS" : EventManager.BL_Inn_CS,
		"Irina_Intro_CS" : EventManager.Irina_Intro_CS,
		"Irina_Meetup_CS" : EventManager.Irina_Meetup_CS,
		"Edgar_Check_In_CS" : EventManager.Edgar_Check_In_CS,
		
	}

var menu_data = {
		"save1" : save1,
		"save1_location" : save1_location,
		"save1_level" : save1_level,
		"save1_frame" : save1_frame,
		"save1_js" : save1_js,
		"save2" : save2,
		"save2_location" : save2_location,
		"save2_level" : save2_level,
		"save2_frame" : save2_frame,
		"save2_js" : save2_js,
		"save3" : save3,
		"save3_location" : save3_location,
		"save3_level" : save3_level,
		"save3_frame" : save3_frame,
		"save3_js" : save3_js,
	}
	
func _ready():
	load_base_file()
	set_menu()
	
	if SceneManager.loading:
		if Music.id != "Overworld" or not Music.is_playing:
			Music.switch_songs()
			Music.id = "Overworld"
			Music.music()
	
func set_menu():
	if save1:
		$Save1/Initial.hide()
		$Save1/Display.show()
		$Save1/Location.text = save1_location
		$Save1/Level_info.text = save1_level
		$Save1/Display.frame = save1_frame
		if save1_js == 1:
			$Save1/Seed1.show()
		if save1_js == 2:
			$Save1/Seed1.show()
			$Save1/Seed2.show()
		if save1_js == 3:
			$Save1/Seed1.show()
			$Save1/Seed2.show()
			$Save1/Seed3.show()
		if save1_js == 4:
			$Save1/Seed1.show()
			$Save1/Seed2.show()
			$Save1/Seed3.show()
			$Save1/Seed4.show()
		if save1_js == 5:
			$Save1/Seed1.show()
			$Save1/Seed2.show()
			$Save1/Seed3.show()
			$Save1/Seed4.show()
			$Save1/Seed5.show()
		if save1_js == 6:
			$Save1/Seed1.show()
			$Save1/Seed2.show()
			$Save1/Seed3.show()
			$Save1/Seed4.show()
			$Save1/Seed5.show()
			$Save1/Seed6.show()
		if save1_js == 7:
			$Save1/Seed1.show()
			$Save1/Seed2.show()
			$Save1/Seed3.show()
			$Save1/Seed4.show()
			$Save1/Seed5.show()
			$Save1/Seed6.show()
			$Save1/Seed7.show()
			
	if save2:
		$Save2/Initial.hide()
		$Save2/Display.show()
		$Save2/Location.text = save2_location
		$Save2/Level_info.text = save2_level
		$Save2/Display.frame = save2_frame
		if save2_js == 1:
			$Save2/Seed1.show()
		if save2_js == 2:
			$Save2/Seed1.show()
			$Save2/Seed2.show()
		if save2_js == 3:
			$Save2/Seed1.show()
			$Save2/Seed2.show()
			$Save2/Seed3.show()
		if save2_js == 4:
			$Save2/Seed1.show()
			$Save2/Seed2.show()
			$Save2/Seed3.show()
			$Save2/Seed4.show()
		if save2_js == 5:
			$Save2/Seed1.show()
			$Save2/Seed2.show()
			$Save2/Seed3.show()
			$Save2/Seed4.show()
			$Save2/Seed5.show()
		if save2_js == 6:
			$Save2/Seed1.show()
			$Save2/Seed2.show()
			$Save2/Seed3.show()
			$Save2/Seed4.show()
			$Save2/Seed5.show()
			$Save2/Seed6.show()
		if save2_js == 7:
			$Save2/Seed1.show()
			$Save2/Seed2.show()
			$Save2/Seed3.show()
			$Save2/Seed4.show()
			$Save2/Seed5.show()
			$Save2/Seed6.show()
			$Save2/Seed7.show()
			
	if save3:
		$Save3/Initial.hide()
		$Save3/Display.show()
		$Save3/Location.text = save3_location
		$Save3/Level_info.text = save3_level
		$Save3/Display.frame = save3_frame
		if save3_js == 1:
			$Save3/Seed1.show()
		if save3_js == 2:
			$Save3/Seed1.show()
			$Save3/Seed2.show()
		if save3_js == 3:
			$Save3/Seed1.show()
			$Save3/Seed2.show()
			$Save3/Seed3.show()
		if save3_js == 4:
			$Save3/Seed1.show()
			$Save3/Seed2.show()
			$Save3/Seed3.show()
			$Save3/Seed4.show()
		if save3_js == 5:
			$Save3/Seed1.show()
			$Save3/Seed2.show()
			$Save3/Seed3.show()
			$Save3/Seed4.show()
			$Save3/Seed5.show()
		if save3_js == 6:
			$Save3/Seed1.show()
			$Save3/Seed2.show()
			$Save3/Seed3.show()
			$Save3/Seed4.show()
			$Save3/Seed5.show()
			$Save3/Seed6.show()
		if save3_js == 7:
			$Save3/Seed1.show()
			$Save3/Seed2.show()
			$Save3/Seed3.show()
			$Save3/Seed4.show()
			$Save3/Seed5.show()
			$Save3/Seed6.show()
			$Save3/Seed7.show()
	
func save_file():
	var file = File.new()
	file.open_encrypted_with_pass(save_path, File.WRITE, "P#ableDH")
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "P#ableDH")
	if error == OK:
		data["save1"] = save1
		data["save1_location"] = save1_location
		data["save1_level"] = save1_level
		data["save1_frame"] = save1_frame
		data["save1_js"] = save1_js
		data["save2"] = save2
		data["save2_location"] = save2_location
		data["save2_level"] = save2_level
		data["save2_frame"] = save2_frame
		data["save2_js"] = save2_js
		data["save3"] = save3
		data["save3_location"] = save3_location
		data["save3_level"] = save3_level
		data["save3_frame"] = save3_frame
		data["save3_js"] = save3_js
		
		data["location"] = SceneManager.location
		data["door_name"] = Global.door_name
		data["jewel_seeds"] = Party.jewel_seeds
		data["marbles"] = Party.marbles
		data["Tutorial"] = Party.Tutorial
		data["Inventory"] = Party.Inventory
		data["Storage"] = Party.Storage
		data["Trinkets"] = Party.Trinkets
		data["KeyItems"] = Party.KeyItems
		data["EnemyList"] = Party.EnemyList
		data["Gary_Spells"] = Party.Gary_Spells
		data["Jacques_Spells"] = Party.Jacques_Spells
		data["Irina_Spells"] = Party.Irina_Spells
		data["Suzy_Spells"] = Party.Suzy_Spells
		data["Damien_Spells"] = Party.Damien_Spells
		data["Tom"] = Shops.Tom
		
		data["party_members"] = PartyStats.party_members
		data["party_level"] = PartyStats.party_level
		data["gary_id"] = PartyStats.gary_id
		data["jacques_id"] = PartyStats.jacques_id
		data["irina_id"] = PartyStats.irina_id
		data["suzy_id"] = PartyStats.suzy_id
		data["damien_id"] = PartyStats.damien_id
		data["gary_trinket"] = PartyStats.gary_trinket
		data["jacques_trinket"] = PartyStats.jacques_trinket
		data["irina_trinket"] = PartyStats.irina_trinket
		data["suzy_trinket"] = PartyStats.suzy_trinket
		data["damien_trinket"] = PartyStats.damien_trinket
		data["gary_current_health"] = PartyStats.gary_current_health
		data["jacques_current_health"] = PartyStats.jacques_current_health
		data["irina_current_health"] = PartyStats.irina_current_health
		data["suzy_current_health"] = PartyStats.suzy_current_health
		data["damien_current_health"] = PartyStats.damien_current_health
		data["party_sp"] = PartyStats.party_sp
		data["party_max_sp"] = PartyStats.party_max_sp
		data["party_exp"] = PartyStats.party_exp
		data["next_level"] = PartyStats.next_level
		data["new_spell_2"] = PartyStats.new_spell_2
		
		data["new_file"] = EventManager.new_file
		data["first_save"] = EventManager.first_save
		
		data["Cherry_Trail"] = EventManager.Cherry_Trail
		data["Pivot_Town"] = EventManager.Pivot_Town
		data["Kugi_Canyon"] = EventManager.Kugi_Canyon
		data["Berry_Lake"] = EventManager.Berry_Lake
		
		data["Michael_Meetup_CS"] = EventManager.Michael_Meetup_CS
		data["Tindrum"] = EventManager.Tindrum
		data["Jacques_Meetup_CS"] = EventManager.Jacques_Meetup_CS
		data["Edgar_Tea_CS"] = EventManager.Edgar_Tea_CS
		data["kugi_canyon_extra"] = EventManager.kugi_canyon_extra
		data["Saguarotel_Intro"] = EventManager.Saguarotel_Intro
		data["Saguarotel"] = EventManager.Saguarotel
		data["Reeler"] = EventManager.Reeler
		data["BL_Inn_CS"] = EventManager.BL_Inn_CS
		data["Irina_Intro_CS"] = EventManager.Irina_Intro_CS
		data["Irina_Meetup_CS"] = EventManager.Irina_Meetup_CS
		data["Edgar_Check_In_CS"] = EventManager.Edgar_Check_In_CS
		
		file.store_var(data, true)
		file.close()
		
func save_base_file():
	var file = File.new()
	file.open_encrypted_with_pass(base_path, File.WRITE, "P#ableDH")
	var error = file.open_encrypted_with_pass(base_path, File.WRITE, "P#ableDH")
	if error == OK:
		menu_data["save1"] = save1
		menu_data["save1_location"] = save1_location
		menu_data["save1_level"] = save1_level
		menu_data["save1_frame"] = save1_frame
		menu_data["save1_js"]	 = save1_js
	
		menu_data["save2"] = save2
		menu_data["save2_location"] = save2_location
		menu_data["save2_level"] = save2_level
		menu_data["save2_frame"] = save2_frame
		menu_data["save2_js"] = save2_js
			
		menu_data["save3"] = save3
		menu_data["save3_location"] = save3_location
		menu_data["save3_level"] = save3_level
		menu_data["save3_frame"] = save3_frame
		menu_data["save3_js"] = save3_js
		
		file.store_var(menu_data, true)
		file.close()
		
func load_file():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P#ableDH")
		if error == OK:
			data = file.get_var(true)
			save1 = data["save1"] 
			save1_location = data["save1_location"]
			save1_level = data["save1_level"]
			save1_frame = data["save1_frame"]
			save1_js = data["save1_js"]
			save2 = data["save2"]
			save2_location = data["save2_location"]
			save2_level = data["save2_level"]
			save2_frame = data["save2_frame"] 
			save2_js = data["save2_js"]
			save3 = data["save3"]
			save3_location = data["save3_location"]
			save3_level = data["save3_level"]
			save3_frame = data["save3_frame"]
			save3_js = data["save3_js"]
		
			SceneManager.location = data["location"]
			Global.door_name = data["door_name"]
			Party.jewel_seeds = data["jewel_seeds"]
			Party.marbles = data["marbles"]
			Party.Tutorial = data["Tutorial"] 
			Party.Inventory = data["Inventory"]
			Party.Storage = data["Storage"]
			Party.Trinkets = data["Trinkets"]
			Party.KeyItems = data["KeyItems"]
			Party.EnemyList = data["EnemyList"]
			Party.Gary_Spells = data["Gary_Spells"]
			Party.Jacques_Spells = data["Jacques_Spells"]
			Party.Irina_Spells = data["Irina_Spells"]
			Party.Suzy_Spells = data["Suzy_Spells"]
			Party.Damien_Spells = data["Damien_Spells"]
			Shops.Tom = data["Tom"]
		
			PartyStats.party_members = data["party_members"]
			PartyStats.party_level = data["party_level"]
			PartyStats.gary_id = data["gary_id"]
			PartyStats.jacques_id = data["jacques_id"]
			PartyStats.irina_id = data["irina_id"]
			PartyStats.suzy_id = data["suzy_id"]
			PartyStats.damien_id = data["damien_id"]
			PartyStats.gary_trinket = data["gary_trinket"]
			PartyStats.jacques_trinket = data["jacques_trinket"]
			PartyStats.irina_trinket = data["irina_trinket"]
			PartyStats.suzy_trinket = data["suzy_trinket"]
			PartyStats.damien_trinket = data["damien_trinket"]
			PartyStats.gary_current_health = data["gary_current_health"]
			PartyStats.jacques_current_health = data["jacques_current_health"]
			PartyStats.irina_current_health = data["irina_current_health"]
			PartyStats.suzy_current_health = data["suzy_current_health"]
			PartyStats.damien_current_health = data["damien_current_health"]
			PartyStats.party_sp = data["party_sp"]
			PartyStats.party_max_sp = data["party_max_sp"]
			PartyStats.party_exp = data["party_exp"]
			PartyStats.next_level = data["next_level"]
			PartyStats.new_spell_2 = data["new_spell_2"]
		
			EventManager.new_file = data["new_file"]
			EventManager.first_save = data["first_save"]
		
			EventManager.Cherry_Trail = data["Cherry_Trail"]
			EventManager.Pivot_Town = data["Pivot_Town"]
			EventManager.Kugi_Canyon = data["Kugi_Canyon"]
			EventManager.Berry_Lake = data["Berry_Lake"]
		
			EventManager.Michael_Meetup_CS = data["Michael_Meetup_CS"]
			EventManager.Tindrum = data["Tindrum"]
			EventManager.Jacques_Meetup_CS = data["Jacques_Meetup_CS"]
			EventManager.Edgar_Tea_CS = data["Edgar_Tea_CS"]
			EventManager.kugi_canyon_extra = data["kugi_canyon_extra"]
			EventManager.Saguarotel_Intro = data["Saguarotel_Intro"]
			EventManager.Saguarotel = data["Saguarotel"]
			EventManager.Reeler = data["Reeler"]
			EventManager.BL_Inn_CS = data["BL_Inn_CS"]
			EventManager.Irina_Intro_CS = data["Irina_Intro_CS"]
			EventManager.Irina_Meetup_CS = data["Irina_Meetup_CS"]
			EventManager.Edgar_Check_In_CS = data["Edgar_Check_In_CS"]
		
			file.close()
			
func load_base_file():
	var file = File.new()
	if file.file_exists("user://save.dat_1"):
		var error = file.open_encrypted_with_pass("user://save.dat_1", File.READ, "P#ableDH")
		if error == OK:
			menu_data = file.get_var(true)
			
			save1 = menu_data["save1"]
			save1_location = menu_data["save1_location"]
			save1_level = menu_data["save1_level"]
			save1_frame = menu_data["save1_frame"]
			save1_js = menu_data["save1_js"]
			
	file = File.new()
	if file.file_exists("user://save.dat_2"):
		var error = file.open_encrypted_with_pass("user://save.dat_2", File.READ, "P#ableDH")
		if error == OK:
			menu_data = file.get_var(true)
			
			save2 = menu_data["save2"]
			save2_location = menu_data["save2_location"]
			save2_level = menu_data["save2_level"]
			save2_frame = menu_data["save2_frame"]
			save2_js = menu_data["save2_js"]
			
	file = File.new()
	if file.file_exists("user://save.dat_3"):
		var error = file.open_encrypted_with_pass("user://save.dat_3", File.READ, "P#ableDH")
		if error == OK:
			menu_data = file.get_var(true)
			
			save3 = menu_data["save3"]
			save3_location = menu_data["save3_location"]
			save3_level = menu_data["save3_level"]
			save3_frame = menu_data["save3_frame"]
			save3_js = menu_data["save3_js"]
			
			
			file.close()
	
func _input(event):
	var file_name : String = $SaveSelection/MenuCursor.menu_name
	
	if Input.is_action_just_pressed("ui_select") and file_name == "1" and SceneManager.saving and able:
		$SaveSelection/MenuCursor.ongoing = true
		SE.effect("Switch")
		able = false
		EventManager.first_save = true
		save1 = true
		save_path = "user://save.dat_1"
		save1_update()
		save_file()
		#save_base_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "2" and SceneManager.saving and able:
		$SaveSelection/MenuCursor.ongoing = true
		SE.effect("Switch")
		able = false
		EventManager.first_save = true
		save2 = true
		save_path = "user://save.dat_2"
		save2_update()
		save_file()
		#save_base_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "3" and SceneManager.saving and able:
		$SaveSelection/MenuCursor.ongoing = true
		SE.effect("Switch")
		able = false
		EventManager.first_save = true
		save3 = true
		save_path = "user://save.dat_3"
		save3_update()
		save_file()
		#save_base_file()
		
	#####################################################
		
	if Input.is_action_just_pressed("ui_select") and file_name == "1" and SceneManager.loading and able:
		if save1:
			$SaveSelection/MenuCursor.ongoing = true
			able = false
			SE.effect("Switch")
			save_path = "user://save.dat_1"
			load_file()
			PartyStats.set_stats()
			yield(get_tree().create_timer(0.6), "timeout")
			load_scene()
		else:
			$SaveSelection/MenuCursor.ongoing = true
			able = false
			SE.effect("Switch")
			yield(get_tree().create_timer(0.6), "timeout")
			opening()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "2" and SceneManager.loading and able:
		if save2:
			$SaveSelection/MenuCursor.ongoing = true
			able = false
			SE.effect("Switch")
			save_path = "user://save.dat_2"
			load_file()
			PartyStats.set_stats()
			yield(get_tree().create_timer(0.6), "timeout")
			load_scene()
		else:
			$SaveSelection/MenuCursor.ongoing = true
			able = false
			SE.effect("Switch")
			yield(get_tree().create_timer(0.6), "timeout")
			opening()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "3" and SceneManager.loading and able:
		if save3:
			$SaveSelection/MenuCursor.ongoing = true
			able = false
			SE.effect("Switch")
			save_path = "user://save.dat_3"
			load_file()
			PartyStats.set_stats()
			yield(get_tree().create_timer(0.6), "timeout")
			load_scene()
		else:
			$SaveSelection/MenuCursor.ongoing = true
			able = false
			SE.effect("Switch")
			yield(get_tree().create_timer(0.6), "timeout")
			opening()
		
	####################################################
	
	#if Input.is_action_just_pressed("ui_select") and file_name == "1" and SceneManager.loading and not save1 and able:
		#$SaveSelection/MenuCursor.ongoing = true
		#able = false
		#SE.effect("Switch")
		#save_path = "user://save.dat_1"
		#load_file()
		
	#if Input.is_action_just_pressed("ui_select") and file_name == "2" and SceneManager.loading and not save2 and able:
		#$SaveSelection/MenuCursor.ongoing = true
		#able = false
		#SE.effect("Switch")
		#save_path = "user://save.dat_2"
		#load_file()
		
	#if Input.is_action_just_pressed("ui_select") and file_name == "3" and SceneManager.loading and not save3 and able:
		#$SaveSelection/MenuCursor.ongoing = true
		#able = false
		#SE.effect("Switch")
		#save_path = "user://save.dat_3"
		#load_file()
		
		
		
func save1_update():
	$Save1/Location.text = SceneManager.location
	$Save1/Level_info.text = str(PartyStats.party_level)
	$Save1/Initial.hide()
	$Save1/Display.show()
	if PartyStats.gary_id == 1:
		$Save1/Display.frame = 0
	if PartyStats.jacques_id == 1:
		$Save1/Display.frame = 1
	if PartyStats.irina_id == 1:
		$Save1/Display.frame = 2
	if PartyStats.suzy_id == 1:
		$Save1/Display.frame = 3
	if PartyStats.damien_id == 1:
		$Save1/Display.frame = 4
	if Party.jewel_seeds == 1:
		$Save1/Seed1.show()
	if Party.jewel_seeds == 2:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
	if Party.jewel_seeds == 3:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
	if Party.jewel_seeds == 4:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
	if Party.jewel_seeds == 5:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
	if Party.jewel_seeds == 6:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
		$Save1/Seed6.show()
	if Party.jewel_seeds == 7:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
		$Save1/Seed6.show()
		$Save1/Seed7.show()
	save1_location = SceneManager.location
	save1_level = str(PartyStats.party_level)
	save1_frame = $Save1/Display.frame
	save1_js = Party.jewel_seeds
		
func save2_update():
	$Save2/Location.text = SceneManager.location
	$Save2/Level_info.text = str(PartyStats.party_level)
	$Save2/Initial.hide()
	$Save2/Display.show()
	if PartyStats.gary_id == 1:
		$Save2/Display.frame = 0
	if PartyStats.jacques_id == 1:
		$Save2/Display.frame = 1
	if PartyStats.irina_id == 1:
		$Save2/Display.frame = 2
	if PartyStats.suzy_id == 1:
		$Save2/Display.frame = 3
	if PartyStats.damien_id == 1:
		$Save2/Display.frame = 4
	if Party.jewel_seeds == 1:
		$Save2/Seed1.show()
	if Party.jewel_seeds == 2:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
	if Party.jewel_seeds == 3:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
	if Party.jewel_seeds == 4:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
	if Party.jewel_seeds == 5:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
	if Party.jewel_seeds == 6:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
		$Save2/Seed6.show()
	if Party.jewel_seeds == 7:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
		$Save2/Seed6.show()
		$Save2/Seed7.show()
	save2_location = SceneManager.location
	save2_level = str(PartyStats.party_level)
	save2_frame = $Save2/Display.frame
	save2_js = Party.jewel_seeds
	
func save3_update():
	$Save3/Location.text = SceneManager.location
	$Save3/Level_info.text = str(PartyStats.party_level)
	$Save3/Initial.hide()
	$Save3/Display.show()
	if PartyStats.gary_id == 1:
		$Save3/Display.frame = 0
	if PartyStats.jacques_id == 1:
		$Save3/Display.frame = 1
	if PartyStats.irina_id == 1:
		$Save3/Display.frame = 2
	if PartyStats.suzy_id == 1:
		$Save3/Display.frame = 3
	if PartyStats.damien_id == 1:
		$Save3/Display.frame = 4
	if Party.jewel_seeds == 1:
		$Save3/Seed1.show()
	if Party.jewel_seeds == 2:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
	if Party.jewel_seeds == 3:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
	if Party.jewel_seeds == 4:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
	if Party.jewel_seeds == 5:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
	if Party.jewel_seeds == 6:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
		$Save3/Seed6.show()
	if Party.jewel_seeds == 7:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
		$Save3/Seed6.show()
		$Save3/Seed7.show()
	save3_location = SceneManager.location
	save3_level = str(PartyStats.party_level)
	save3_frame = $Save3/Display.frame
	save3_js = Party.jewel_seeds

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name

func load_scene():
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	if SceneManager.location == "Gary's House":
		transition.transition_in(Garys_House, _get_animation_name())
		yield(get_tree().create_timer(0.7), "timeout")
		SceneManager.loading = false
	if SceneManager.location == "Cherry Trail":
		transition.transition_in(Cherry_Trail, _get_animation_name())
		yield(get_tree().create_timer(0.7), "timeout")
		SceneManager.loading = false
	if SceneManager.location == "Pivot Town":
		transition.transition_in(Pivot_Town, _get_animation_name())
		yield(get_tree().create_timer(0.7), "timeout")
		SceneManager.loading = false
	if SceneManager.location == "Kugi Canyon":
		transition.transition_in(Kugi_Canyon, _get_animation_name())
		yield(get_tree().create_timer(0.7), "timeout")
		SceneManager.loading = false
	if SceneManager.location == "Berry Lake":
		transition.transition_in(Berry_Lake, _get_animation_name())
		yield(get_tree().create_timer(0.7), "timeout")
		SceneManager.loading = false

func opening():
	pass
