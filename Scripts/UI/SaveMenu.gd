extends Node2D

#onready var player_instance = PlayerManager.player_instance
#var save_path = "res://save.dat"
var save_path : String
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
		"party_members" : PartyStats.party_members,
		"party_level" : PartyStats.party_level,
		
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
	
func _process(delta):
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
		file.store_var(data)
		file.close()
		
func load_file():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P#ableDH")
		if error == OK:
			var player_data = file.get_var(true)
			file.close()
			PartyStats.party_members = player_data["party_members"]
			PartyStats.party_level = player_data["party_level"]
			
func load_base_file():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P#ableDH")
		if error == OK:
			var player_data = file.get_var(true)
			file.close()
			PartyStats.party_members = player_data["party_members"]
			PartyStats.party_level = player_data["party_level"]
			save1 = player_data["save1"]
			save1_location = player_data["save1_location"]
			save1_level = player_data["save1_level"]
			save1_frame = player_data["save1_frame"]
			save1_js = player_data["save1_js"]
			
			save2 = player_data["save2"]
			save2_location = player_data["save2_location"]
			save2_level = player_data["save2_level"]
			save2_frame = player_data["save2_frame"]
			save2_js = player_data["save2_js"]
			
			save3 = player_data["save3"]
			save3_location = player_data["save3_location"]
			save3_level = player_data["save3_level"]
			save3_frame = player_data["save3_frame"]
			save3_js = player_data["save3_js"]
	
func _input(event):
	var file_name : String = $SaveSelection/MenuCursor.menu_name
	
	if Input.is_action_just_pressed("ui_select") and file_name == "1" and SceneManager.saving:
		SE.effect("Switch")
		save_path = "res://save.dat_1"
		save1_update()
		save_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "2" and SceneManager.saving:
		SE.effect("Switch")
		save_path = "res://save.dat_2"
		save2_update()
		save_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "3" and SceneManager.saving:
		SE.effect("Switch")
		save_path = "res://save.dat_3"
		save3_update()
		save_file()
		
	#####################################################
		
	if Input.is_action_just_pressed("ui_select") and file_name == "1" and SceneManager.loading:
		SE.effect("Select")
		save_path = "res://save.dat_1"
		load_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "2" and SceneManager.loading:
		SE.effect("Select")
		save_path = "res://save.dat_2"
		load_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "3" and SceneManager.loading:
		SE.effect("Select")
		save_path = "res://save.dat_3"
		load_file()
		
func save1_update():
	save1 = true
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
	if EventManager.jewel_seeds == 1:
		$Save1/Seed1.show()
	if EventManager.jewel_seeds == 2:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
	if EventManager.jewel_seeds == 3:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
	if EventManager.jewel_seeds == 4:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
	if EventManager.jewel_seeds == 5:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
	if EventManager.jewel_seeds == 6:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
		$Save1/Seed6.show()
	if EventManager.jewel_seeds == 7:
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
	save1_js = EventManager.jewel_seeds
		
func save2_update():
	save2 = true
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
	if EventManager.jewel_seeds == 1:
		$Save2/Seed1.show()
	if EventManager.jewel_seeds == 2:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
	if EventManager.jewel_seeds == 3:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
	if EventManager.jewel_seeds == 4:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
	if EventManager.jewel_seeds == 5:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
	if EventManager.jewel_seeds == 6:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
		$Save2/Seed6.show()
	if EventManager.jewel_seeds == 7:
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
	save2_js = EventManager.jewel_seeds
	
func save3_update():
	save3 = true
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
	if EventManager.jewel_seeds == 1:
		$Save3/Seed1.show()
	if EventManager.jewel_seeds == 2:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
	if EventManager.jewel_seeds == 3:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
	if EventManager.jewel_seeds == 4:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
	if EventManager.jewel_seeds == 5:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
	if EventManager.jewel_seeds == 6:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
		$Save3/Seed6.show()
	if EventManager.jewel_seeds == 7:
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
	save3_js = EventManager.jewel_seeds
