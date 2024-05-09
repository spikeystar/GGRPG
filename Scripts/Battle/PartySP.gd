extends Label


func _ready():
	text = "SP: " + str(Party.party_sp) + "/" + str(Party.party_max_sp)
