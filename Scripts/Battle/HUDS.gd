extends VBoxContainer

var heal_health : int
var max_health : int
var health
var f_health

var stun = false
var poison = false
var wimpy = false
var dizzy = false
var targeted = false
var anxious = false
var current_type : String
var a_buff = false
var a_debuff = false
var m_buff = false
var m_debuff = false
var d_buff = false
var d_debuff = false

func _ready():
	initial_health()
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
	$GaryHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$GaryHud/Dead.show()
		$GaryHud/Icons.hide()
	if health >0:
		$GaryHud/Dead.hide()
		$GaryHud/Icons.show()
	gary_statuses()
	
func jacques_update():
	$JacquesHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$JacquesHud/Dead.show()
		$JacquesHud/Icons.hide()
	if health >0:
		$JacquesHud/Dead.hide()
		$JacquesHud/Icons.show()
	jacques_statuses()
	
func irina_update():
	$IrinaHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$IrinaHud/Dead.show()
		$IrinaHud/Icons.hide()
	if health >0:
		$IrinaHud/Dead.hide()
		$IrinaHud/Icons.show()
	irina_statuses()
	
#######

func gary_statuses():
	if stun:
		$GaryHud/Icons/Stun.show()
	elif not stun:
		$GaryHud/Icons/Stun.hide()
	elif poison:
		$GaryHud/Icons/Poison.show()
	elif not poison:
		$GaryHud/Icons/Poison.hide()
	elif anxious:
		$GaryHud/Icons/Anxious.show()
	elif not anxious:
		$GaryHud/Icons/Anxious.hide()
	elif wimpy:
		$GaryHud/Icons/Wimpy.show()
	elif not wimpy:
		$GaryHud/Icons/Wimpy.hide()
	elif dizzy:
		$GaryHud/Icons/Dizzy.show()
	elif not dizzy:
		$GaryHud/Icons/Dizzy.hide()
	elif targeted:
		$GaryHud/Icons/Targeted.show()
	elif not targeted:
		$GaryHud/Icons/Targeted.hide()
	elif a_buff:
		$GaryHud/Icons/Attack.show()
	elif not a_buff:
		$GaryHud/Icons/Attack.hide()
	elif a_debuff:
		$GaryHud/Icons/Attack_D.show()
	elif not a_debuff:
		$GaryHud/Icons/Attack_D.hide()
	elif m_buff:
		$GaryHud/Icons/Magic.show()
	elif not m_buff:
		$GaryHud/Icons/Magic.hide()
	elif m_debuff:
		$GaryHud/Icons/Magic_D.show()
	elif not m_debuff:
		$GaryHud/Icons/Magic_D.hide()
	elif d_buff:
		$GaryHud/Icons/Defense.show()
	elif not d_buff:
		$GaryHud/Icons/Defense.hide()
	elif d_debuff:
		$GaryHud/Icons/Defense_D.show()
	elif not d_debuff:
		$GaryHud/Icons/Defense_D.hide()
	elif current_type == "neutral":
		$GaryHud/Icons/Type.hide()
	elif current_type == "fire":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 0
	elif current_type == "water":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 1
	elif current_type == "air":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 4
	elif current_type == "earth":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 5
		
func jacques_statuses():
	if stun:
		$JacquesHud/Icons/Stun.show()
	elif not stun:
		$JacquesHud/Icons/Stun.hide()
	elif poison:
		$JacquesHud/Icons/Poison.show()
	elif not poison:
		$JacquesHud/Icons/Poison.hide()
	elif anxious:
		$JacquesHud/Icons/Anxious.show()
	elif not anxious:
		$JacquesHud/Icons/Anxious.hide()
	elif wimpy:
		$JacquesHud/Icons/Wimpy.show()
	elif not wimpy:
		$JacquesHud/Icons/Wimpy.hide()
	elif dizzy:
		$JacquesHud/Icons/Dizzy.show()
	elif not dizzy:
		$JacquesHud/Icons/Dizzy.hide()
	elif targeted:
		$JacquesHud/Icons/Targeted.show()
	elif not targeted:
		$JacquesHud/Icons/Targeted.hide()
	elif a_buff:
		$JacquesHud/Icons/Attack.show()
	elif not a_buff:
		$JacquesHud/Icons/Attack.hide()
	elif a_debuff:
		$JacquesHud/Icons/Attack_D.show()
	elif not a_debuff:
		$JacquesHud/Icons/Attack_D.hide()
	elif m_buff:
		$JacquesHud/Icons/Magic.show()
	elif not m_buff:
		$JacquesHud/Icons/Magic.hide()
	elif m_debuff:
		$JacquesHud/Icons/Magic_D.show()
	elif not m_debuff:
		$JacquesHud/Icons/Magic_D.hide()
	elif d_buff:
		$JacquesHud/Icons/Defense.show()
	elif not d_buff:
		$JacquesHud/Icons/Defense.hide()
	elif d_debuff:
		$JacquesHud/Icons/Defense_D.show()
	elif not d_debuff:
		$JacquesHud/Icons/Defense_D.hide()
	elif current_type == "neutral":
		$JacquesHud/Icons/Type.hide()
	elif current_type == "fire":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 0
	elif current_type == "water":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 1
	elif current_type == "air":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 4
	elif current_type == "earth":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 5
		
func irina_statuses():
	if stun:
		$IrinaHud/Icons/Stun.show()
	elif not stun:
		$IrinaHud/Icons/Stun.hide()
	elif poison:
		$IrinaHud/Icons/Poison.show()
	elif not poison:
		$IrinaHud/Icons/Poison.hide()
	elif anxious:
		$IrinaHud/Icons/Anxious.show()
	elif not anxious:
		$IrinaHud/Icons/Anxious.hide()
	elif wimpy:
		$IrinaHud/Icons/Wimpy.show()
	elif not wimpy:
		$IrinaHud/Icons/Wimpy.hide()
	elif dizzy:
		$IrinaHud/Icons/Dizzy.show()
	elif not dizzy:
		$IrinaHud/Icons/Dizzy.hide()
	elif targeted:
		$IrinaHud/Icons/Targeted.show()
	elif not targeted:
		$IrinaHud/Icons/Targeted.hide()
	elif a_buff:
		$IrinaHud/Icons/Attack.show()
	elif not a_buff:
		$IrinaHud/Icons/Attack.hide()
	elif a_debuff:
		$IrinaHud/Icons/Attack_D.show()
	elif not a_debuff:
		$IrinaHud/Icons/Attack_D.hide()
	elif m_buff:
		$IrinaHud/Icons/Magic.show()
	elif not m_buff:
		$IrinaHud/Icons/Magic.hide()
	elif m_debuff:
		$IrinaHud/Icons/Magic_D.show()
	elif not m_debuff:
		$IrinaHud/Icons/Magic_D.hide()
	elif d_buff:
		$IrinaHud/Icons/Defense.show()
	elif not d_buff:
		$IrinaHud/Icons/Defense.hide()
	elif d_debuff:
		$IrinaHud/Icons/Defense_D.show()
	elif not d_debuff:
		$IrinaHud/Icons/Defense_D.hide()
	elif current_type == "neutral":
		$IrinaHud/Icons/Type.hide()
	elif current_type == "fire":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 0
	elif current_type == "water":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 1
	elif current_type == "air":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 4
	elif current_type == "earth":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 5
		
func gary_update_heal():
	$GaryHud/Health.text = str(heal_health) + "/" + str(max_health)
	if heal_health >0:
		$GaryHud/Dead.hide()
	
func jacques_update_heal():
	$JacquesHud/Health.text = str(heal_health) + "/" + str(max_health)
	if heal_health >0:
		$JacquesHud/Dead.hide()
	
func irina_update_heal():
	$IrinaHud/Health.text = str(heal_health) + "/" + str(max_health)
	if heal_health >0:
		$IrinaHud/Dead.hide()

func initial_health():
	$GaryHud/Health.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
	$JacquesHud/Health.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
	$IrinaHud/Health.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
