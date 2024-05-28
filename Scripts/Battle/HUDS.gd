extends VBoxContainer
onready var Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")

func _ready():
	$GaryHud.hide()
	$JacquesHud.hide()
	$IrinaHud.hide()
	if PartyStats.party_members == 1:
		$GaryHud.show()
		$GaryHud.position = Vector2(26,46)
		
	if PartyStats.party_members == 2:
		if PartyStats.gary_id == 1:
			$GaryHud.show()
			$GaryHud.position = Vector2(79,26)
		if PartyStats.gary_id == 2:
			$GaryHud.show()
			$GaryHud.position = Vector2(15,108)
		if PartyStats.jacques_id == 1:
			$JacquesHud.show()
			$JacquesHud.position = Vector2(76,29)
		if PartyStats.jacques_id == 2:
			$JacquesHud.show()
			$JacquesHud.position = Vector2(15,108)
	
	if PartyStats.party_members >= 3:
		if PartyStats.gary_id == 1:
			$GaryHud.show()
			$GaryHud.position = Vector2(120,13)
		if PartyStats.gary_id == 2:
			$GaryHud.show()
			$GaryHud.position = Vector2(59,92)
		if PartyStats.gary_id == 3:
			$GaryHud.show()
			$GaryHud.position = Vector2(2,174)
		if PartyStats.jacques_id == 1:
			$JacquesHud.show()
			$JacquesHud.position = Vector2(120,13)
		if PartyStats.jacques_id == 2:
			$JacquesHud.show()
			$JacquesHud.position = Vector2(59,92)
		if PartyStats.jacques_id == 3:
			$JacquesHud.show()
			$JacquesHud.position = Vector2(2,174)
		if PartyStats.irina_id == 1:
			$IrinaHud.show()
			$IrinaHud.position = Vector2(120,13)
		if PartyStats.irina_id == 2:
			$IrinaHud.show()
			$IrinaHud.position = Vector2(59,92)
		if PartyStats.irina_id == 3:
			$IrinaHud.show()
			$IrinaHud.position = Vector2(2,174)

func gary_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$GaryHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$GaryHud/Dead.show()
	if health >0:
		$GaryHud/Dead.hide()
	
func jacques_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$JacquesHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$JacquesHud/Dead.show()
	if health >0:
		$JacquesHud/Dead.hide()
	
func irina_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$IrinaHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$IrinaHud/Dead.show()
	if health >0:
		$IrinaHud/Dead.hide()
	
#######

func gary_update_heal():
	var health = Fighters.health
	var f_health = Fighters.f_health
	$GaryHud/Health.text = str(health) + "/" + str(f_health)
	if health >0:
		$GaryHud/Dead.hide()
	
func jacques_update_heal():
	var health = Fighters.health
	var f_health = Fighters.f_health
	$JacquesHud/Health.text = str(health) + "/" + str(f_health)
	if health >0:
		$JacquesHud/Dead.hide()
	
func irina_update_heal():
	var health = Fighters.health
	var f_health = Fighters.f_health
	$IrinaHud/Health.text = str(health) + "/" + str(f_health)
	if health >0:
		$IrinaHud/Dead.hide()
