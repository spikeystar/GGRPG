extends Node

var party_id : int
var party_members = 3
var member_name : String
var holder_name : String

var gary_id = 2
var gary_health = 87
var gary_current_health = 20
var gary_attack = 25
var gary_magic = 23
var gary_defense = 15
var gary_trinket : String = "-"

var jacques_id = 1
var jacques_health = 103
var jacques_current_health = 20
var jacques_attack = 20
var jacques_magic = 27
var jacques_defense = 24
var jacques_trinket : String = "-"

var irina_id = 3
var irina_health = 122
var irina_current_health = 122
var irina_attack = 17
var irina_magic = 25
var irina_defense = 15
var irina_trinket : String = "-"

var suzy_id = 4
var suzy_health = 122
var suzy_current_health = 122
var suzy_attack = 17
var suzy_magic = 25
var suzy_defense = 15
var suzy_trinket : String = "-"

var damien_id = 5
var damien_health = 122
var damien_current_health = 122
var damien_attack = 17
var damien_magic = 25
var damien_defense = 15
var damien_trinket : String = "-"

var party_sp = 20
var party_max_sp = 50
var party_level = 7
var party_exp = 538
var next_level = 542

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
