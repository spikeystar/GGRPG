extends Sprite

func _ready():
	$SP_amount.text = str(PartyStats.party_sp) + "/" + str(PartyStats.party_max_sp)
	$Marbles_amount.text = thousands_sep(Party.marbles)
	$Level_amount.text = str(PartyStats.party_level)
	$Next_amount.text = thousands_sep(PartyStats.next_level)
	
static func thousands_sep(number, prefix=''):
	var neg = false
	if number < 0:
		number = -number
		neg = true
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	if neg: res = '-'+prefix+res
	else: res = prefix+res
	return res
	
func _process(delta):
	$SP_amount.text = str(PartyStats.party_sp) + "/" + str(PartyStats.party_max_sp)
