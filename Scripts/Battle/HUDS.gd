extends VBoxContainer
onready var Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")

func gary_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$GaryAliveHud/Gary_Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$GaryAliveHud/GaryDead.show()
	if health >0:
		$GaryAliveHud/GaryDead.hide()
	
func jacques_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$JacquesAliveHud/Jacques_Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$JacquesAliveHud/JacquesDead.show()
	if health >0:
		$JacquesAliveHud/JacquesDead.hide()
	
func irina_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$IrinaAliveHud/Irina_Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$IrinaAliveHud/IrinaDead.show()
	if health >0:
		$IrinaAliveHud/IrinaDead.hide()
	
#######

func gary_update_heal():
	var health = Fighters.health
	var f_health = Fighters.f_health
	$GaryAliveHud/Gary_Health.text = str(health) + "/" + str(f_health)
	if health >0:
		$GaryAliveHud/GaryDead.hide()
	
func jacques_update_heal():
	var health = Fighters.health
	var f_health = Fighters.f_health
	$JacquesAliveHud/Jacques_Health.text = str(health) + "/" + str(f_health)
	if health >0:
		$JacquesAliveHud/JacquesDead.hide()
	
func irina_update_heal():
	var health = Fighters.health
	var f_health = Fighters.f_health
	$IrinaAliveHud/Irina_Health.text = str(health) + "/" + str(f_health)
	if health >0:
		$IrinaAliveHud/IrinaDead.hide()
