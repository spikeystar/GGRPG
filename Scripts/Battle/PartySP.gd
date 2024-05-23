extends Label


func _ready():
	text = "SP: " + str(PartyStats.party_sp) + "/" + str(PartyStats.party_max_sp)
