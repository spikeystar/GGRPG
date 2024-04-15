extends Node2D

onready var party_members : int
onready var party_id : int
var fighters : Array = []

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

func _ready():
	if party_members == 1:
		party_formation_1 = true

	if party_members == 2:
		party_formation_2 = true

	if party_members == 3:
		party_formation_3 = true

func _set_position():
	fighters = get_children()
	if party_id == 1 and party_formation_3:
		$PartyFormation3/Fighter1.position
		
	if party_id == 2 and party_formation_3:
		$PartyFormation3/Fighter2.position
		
	if party_id == 3 and party_formation_3:
		$PartyFormation3/Fighter3.position
