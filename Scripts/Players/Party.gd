extends Node

var current_health = 88
var max_health = 88
var attack = 10
#var party_index : int = 1
var party_id : int
var party_members = 3
var f_turns : int = 0

func assign_party_id(party_id):
	$Gary_Battle.party_id = 0
	$Jacques_Battle.party_id = 2
	$Irina_Battle.party_id = 1

