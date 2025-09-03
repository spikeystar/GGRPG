extends Node2D

func _ready():
	return

func spell_check():
	var spell_id = $MagicWindowPanel/SpellList.get_id()
	if spell_id == "Thunderstorm":
		$SpellInfo.text = "Strikes all with lightning bolts\n\n20% chance to stun"
		$SpellCost.text = "SP: 5"
		$MagicWindowPanel/SpellList.spell_cost = 5
		$SpellTypeIcon.frame = 4
	if spell_id == "Earthslide":
		$SpellInfo.text = "Hurls a chunk of ruptured earth at one enemy\n\nInflicts attack debuff"
		$SpellCost.text = "SP: 8"
		$MagicWindowPanel/SpellList.spell_cost = 8
		$SpellTypeIcon.frame = 5
	if spell_id == "Icicle":
		$SpellInfo.text = "Drops a large icicle on one enemy\n\nInflicts defense debuff"
		$SpellCost.text = "SP: 5"
		$MagicWindowPanel/SpellList.spell_cost = 5
		$SpellTypeIcon.frame = 1
	if spell_id == "Prism Snow":
		$SpellInfo.text = "Pelts all enemies with multicolored snow\n\nInflicts random debuffs"
		$SpellCost.text = "SP: 10"
		$MagicWindowPanel/SpellList.spell_cost = 10
		$SpellTypeIcon.frame = 1
	if spell_id == "Sweet Gift":
		$SpellInfo.text = "Heals or revives one party member\n\nRemoves all ailments & grants a random buff"
		$SpellCost.text = "SP: 12"
		$MagicWindowPanel/SpellList.spell_cost = 12
		$SpellTypeIcon.frame = 16
	if spell_id == "Precious Beam":
		$SpellInfo.text = "Singes one enemy with a ray of heavenly light\n\nDoes more damage for each enemy buff, inflicts magic debuff"
		$SpellCost.text = "SP: 15"
		$MagicWindowPanel/SpellList.spell_cost = 15
		$SpellTypeIcon.frame = 0
	
func get_spell_id():
	var spell_id = $MagicWindowPanel/SpellList.get_id()
	return spell_id
	
func _on_Menu_Cursor_magic_active():
	#yield(get_tree().create_timer(0.01), "timeout")
	spell_check()

func _on_WorldRoot_magic_active():
	#yield(get_tree().create_timer(0.01), "timeout")
	spell_check()
