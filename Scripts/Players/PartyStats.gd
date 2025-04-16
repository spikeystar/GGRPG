extends Node

var party_id : int
var party_members = 1
var member_name : String
var holder_name : String

var gary_id = 1
var gary_health = 40
var gary_current_health = 50
var gary_attack = 25
var gary_magic = 23
var gary_defense = 17
var gary_trinket : String = "-"

var jacques_id = 2
var jacques_health = 60
var jacques_current_health = 60
var jacques_attack = 20
var jacques_magic = 27
var jacques_defense = 26
var jacques_trinket : String = "-"

var irina_id = 3
var irina_health = 70
var irina_current_health = 70
var irina_attack = 17
var irina_magic = 25
var irina_defense = 17
var irina_trinket : String = "-"

var suzy_id = 4
var suzy_health = 122
var suzy_current_health = 122
var suzy_attack = 17
var suzy_magic = 25
var suzy_defense = 17
var suzy_trinket : String = "-"

var damien_id = 5
var damien_health = 122
var damien_current_health = 122
var damien_attack = 17
var damien_magic = 25
var damien_defense = 17
var damien_trinket : String = "-"

var party_sp = 20
var party_max_sp = 20
var party_level = 1
var party_exp = 0
var next_level = int((100) * (party_level/1.5) + (party_level * 150))

var new_spell_2 = false

func _ready():
	set_stats()
	gary_current_health = gary_health
	jacques_current_health = jacques_health
	irina_current_health = irina_health
	
	if party_level >= 3:
		Party.spell_name = "Earthslide"
		Party.populate_Gary()
		Party.spell_name = "Prism Snow"
		Party.populate_Jacques()
		new_spell_2 = true

func set_id():
	if member_name == "gary":
		gary_id = party_id
	if member_name == "jacques":
		jacques_id = party_id
	if member_name == "irina":
		irina_id = party_id
	if member_name == "suzy":
		suzy_id = party_id
	if member_name == "damien":
		damien_id = party_id
		
func full_heal():
	gary_current_health = gary_health
	jacques_current_health = jacques_health
	irina_current_health = irina_health
	suzy_current_health = suzy_health
	damien_current_health = damien_health
	party_sp = party_max_sp
	
func level_check():
	set_stats()
	level_up()
	if party_level == 3:
		Party.spell_name = "Earthslide"
		Party.populate_Gary()
		Party.spell_name = "Prism Snow"
		Party.populate_Jacques()
		new_spell_2 = true
		
func level_up():
	party_max_sp += 5
	full_heal()
	next_level = int((100) * (party_level/1.5) + (party_level * 50))
		
func set_stats():	
	gary_health = 51 + int((party_level / 1.5) * 10.5)
	gary_attack = 20 + int((party_level / 1.5) * 7)
	gary_magic = 15 + int((party_level / 1.5)  * 7)
	gary_defense = 5 + int((party_level / 2)  * 2)
	
	jacques_health = 55 + int((party_level / 1.5)  * 14)
	jacques_attack = 20 + int((party_level / 1.5)  * 5)
	jacques_magic = 20 + int((party_level / 1.5) * 5)
	jacques_defense = 7 + int((party_level / 2)  * 3)

	irina_health = 60 + int((party_level / 1.5)  * 18)
	irina_attack = 12 + int((party_level / 1.5)  * 5)
	irina_magic = 24 + int((party_level / 1.5)  * 6)
	irina_defense = 4 + int((party_level / 2)  * 1.5)
	
	suzy_health = 43 + int((party_level / 1.5) * 8)
	suzy_attack = 27 + int((party_level / 1.5) * 8)
	suzy_magic = 20 + int((party_level / 1.5)  * 6)
	suzy_defense = 5 + int((party_level / 2)  * 1)
	
	damien_health = 50 + int((party_level / 1.5)  * 11.5)
	damien_attack = 10 + int((party_level / 1.5)  * 4)
	damien_magic = 30 + int((party_level / 1.5) * 8)
	damien_defense = 6 + int((party_level / 2)  * 2)
	
	if party_level == 1:
		gary_health = 50
		jacques_health = 60
		irina_health = 70
