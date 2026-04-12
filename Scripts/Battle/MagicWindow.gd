extends Node2D

var mystic_catalyst = false
var crux_reactor = false

func _ready():
	return
	
func _process(delta):
	spell_check()

func spell_check():
	#var spell_id = $MagicWindowPanel/SpellList.get_id()
	var spell_id = $MagicWindowPanel/MenuCursor.menu_name
	var cost_base : int
	if spell_id == "Thunderstorm":
		$SpellInfo.text = "Strikes all with lightning bolts\n\n20% chance to stun"
		cost_base = 5
		$SpellTypeIcon.frame = 4
	if spell_id == "Earthslide":
		$SpellInfo.text = "Hurls a chunk of ruptured earth at one enemy\n\nInflicts attack debuff"
		cost_base = 8
		$SpellTypeIcon.frame = 5
	if spell_id == "Icicle":
		$SpellInfo.text = "Drops a large icicle on one enemy\n\nInflicts defense debuff"
		cost_base = 5
		$SpellTypeIcon.frame = 1
	if spell_id == "Prism Snow":
		$SpellInfo.text = "Pelts all enemies with multicolored snow\n\nInflicts random debuffs"
		cost_base = 10
		$SpellTypeIcon.frame = 1
	if spell_id == "Sweet Gift":
		$SpellInfo.text = "Heals or revives one party member\n\nRemoves all ailments & grants a random buff"
		cost_base = 12
		$SpellTypeIcon.frame = 16
	if spell_id == "Precious Beam":
		$SpellInfo.text = "Singes one enemy with a ray of heavenly light\n\nDoes more damage for each enemy buff, inflicts magic debuff"
		cost_base = 15
		$SpellTypeIcon.frame = 0
		
	if mystic_catalyst:
		cost_base = int(cost_base / 2)
	if crux_reactor:
		cost_base = (cost_base + int(cost_base /2))
	$SpellCost.text = "SP: " + str(cost_base)
	$MagicWindowPanel/SpellList.spell_cost = cost_base
	
func get_spell_id():
	var spell_id = $MagicWindowPanel/SpellList.get_id()
	return spell_id
	
func _on_Menu_Cursor_magic_active():
	#yield(get_tree().create_timer(0.01), "timeout")
	spell_check()

func _on_WorldRoot_magic_active():
	#yield(get_tree().create_timer(0.01), "timeout")
	spell_check()
