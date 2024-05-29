extends Label


func _process(delta):
	text = "SP: " + str(PartyStats.party_sp) + "/" + str(PartyStats.party_max_sp)
