extends VBoxContainer
onready var Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")

func gary_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$GaryAliveHud/Gary_Health.text = str(health) + "/" + str(f_health)
	
func jacques_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$JacquesAliveHud/Jacques_Health.text = str(health) + "/" + str(f_health)
	
func irina_update():
	var health = Fighters.get_health()
	var f_health = Fighters.get_f_health()
	$IrinaAliveHud/Irina_Health.text = str(health) + "/" + str(f_health)
