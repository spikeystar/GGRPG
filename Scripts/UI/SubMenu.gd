extends Sprite

func _ready():
	$SP_amount.text = str(PartyStats.party_sp) + "/" + str(PartyStats.party_max_sp)
	$Marbles_amount.text = str(Party.marbles)
	$Level_amount.text = str(PartyStats.party_level)
	$Next_amount.text = str(PartyStats.next_level)
	
func _process(delta):
	$SP_amount.text = str(PartyStats.party_sp) + "/" + str(PartyStats.party_max_sp)
