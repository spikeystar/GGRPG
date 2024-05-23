extends Node

var party_id : int
var party_members = 3
var member_name : String

var gary_id = 1
var gary_health = 87
var gary_attack = 25
var gary_magic = 23
var gary_defense = 15

var jacques_id = 2
var jacques_health = 103
var jacques_attack = 20
var jacques_magic = 27
var jacques_defense = 24

var irina_id = 3
var irina_health = 122
var irina_attack = 17
var irina_magic = 25
var irina_defense = 15

var party_sp = 50
var party_max_sp = 50
var party_level = 7
var party_exp = 538
var next_level = 637

func set_id():
	if member_name == "gary":
		gary_id = party_id
	if member_name == "jacques":
		jacques_id = party_id
	if member_name == "irina":
		irina_id = party_id
