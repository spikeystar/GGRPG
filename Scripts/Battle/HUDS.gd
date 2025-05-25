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
	$SuzyHud.hide()
	$DamienHud.hide()
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
		if PartyStats.suzy_id == 1:
			$SuzyHud.show()
			$SuzyHud.position = Vector2(120,13)
		if PartyStats.suzy_id == 2:
			$SuzyHud.show()
			$SuzyHud.position = Vector2(59,92)
		if PartyStats.suzy_id == 3:
			$SuzyHud.show()
			$SuzyHud.position = Vector2(2,174)
		if PartyStats.damien_id == 1:
			$DamienHud.show()
			$DamienHud.position = Vector2(120,13)
		if PartyStats.damien_id == 2:
			$DamienHud.show()
			$DamienHud.position = Vector2(59,92)
		if PartyStats.damien_id == 3:
			$DamienHud.show()
			$DamienHud.position = Vector2(2,174)
			

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
	
func suzy_update():
	$SuzyHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$SuzyHud/Dead.show()
		$SuzyHud/Icons.hide()
	if health >0:
		$SuzyHud/Dead.hide()
		$SuzyHud/Icons.show()
	suzy_statuses()
	
func damien_update():
	$DamienHud/Health.text = str(health) + "/" + str(f_health)
	if health == 0:
		$DamienHud/Dead.show()
		$DamienHud/Icons.hide()
	if health >0:
		$DamienHud/Dead.hide()
		$DamienHud/Icons.show()
	damien_statuses()
	
#######

func gary_statuses():
	if stun:
		$GaryHud/Icons/Stun.show()
	elif not stun:
		$GaryHud/Icons/Stun.hide()
	if poison:
		$GaryHud/Icons/Poison.show()
	elif not poison:
		$GaryHud/Icons/Poison.hide()
	if anxious:
		$GaryHud/Icons/Anxious.show()
	elif not anxious:
		$GaryHud/Icons/Anxious.hide()
	if wimpy:
		$GaryHud/Icons/Wimpy.show()
	elif not wimpy:
		$GaryHud/Icons/Wimpy.hide()
	if dizzy:
		$GaryHud/Icons/Dizzy.show()
	elif not dizzy:
		$GaryHud/Icons/Dizzy.hide()
	if targeted:
		$GaryHud/Icons/Targeted.show()
	elif not targeted:
		$GaryHud/Icons/Targeted.hide()
	if a_buff:
		$GaryHud/Icons/Attack.show()
	elif not a_buff:
		$GaryHud/Icons/Attack.hide()
	if a_debuff:
		$GaryHud/Icons/Attack_D.show()
	elif not a_debuff:
		$GaryHud/Icons/Attack_D.hide()
	if m_buff:
		$GaryHud/Icons/Magic.show()
	elif not m_buff:
		$GaryHud/Icons/Magic.hide()
	if m_debuff:
		$GaryHud/Icons/Magic_D.show()
	elif not m_debuff:
		$GaryHud/Icons/Magic_D.hide()
	if d_buff:
		$GaryHud/Icons/Defense.show()
	elif not d_buff:
		$GaryHud/Icons/Defense.hide()
	if d_debuff:
		$GaryHud/Icons/Defense_D.show()
	elif not d_debuff:
		$GaryHud/Icons/Defense_D.hide()
	if current_type == "neutral":
		$GaryHud/Icons/Type.hide()
	if current_type == "fire":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 0
	if current_type == "water":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 1
	if current_type == "air":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 4
	if current_type == "earth":
		$GaryHud/Icons/Type.show()
		$GaryHud/Icons/Type.frame = 5
		
func jacques_statuses():
	if stun:
		$JacquesHud/Icons/Stun.show()
	elif not stun:
		$JacquesHud/Icons/Stun.hide()
	if poison:
		$JacquesHud/Icons/Poison.show()
	elif not poison:
		$JacquesHud/Icons/Poison.hide()
	if anxious:
		$JacquesHud/Icons/Anxious.show()
	elif not anxious:
		$JacquesHud/Icons/Anxious.hide()
	if wimpy:
		$JacquesHud/Icons/Wimpy.show()
	elif not wimpy:
		$JacquesHud/Icons/Wimpy.hide()
	if dizzy:
		$JacquesHud/Icons/Dizzy.show()
	elif not dizzy:
		$JacquesHud/Icons/Dizzy.hide()
	if targeted:
		$JacquesHud/Icons/Targeted.show()
	elif not targeted:
		$JacquesHud/Icons/Targeted.hide()
	if a_buff:
		$JacquesHud/Icons/Attack.show()
	elif not a_buff:
		$JacquesHud/Icons/Attack.hide()
	if a_debuff:
		$JacquesHud/Icons/Attack_D.show()
	elif not a_debuff:
		$JacquesHud/Icons/Attack_D.hide()
	if m_buff:
		$JacquesHud/Icons/Magic.show()
	elif not m_buff:
		$JacquesHud/Icons/Magic.hide()
	if m_debuff:
		$JacquesHud/Icons/Magic_D.show()
	elif not m_debuff:
		$JacquesHud/Icons/Magic_D.hide()
	if d_buff:
		$JacquesHud/Icons/Defense.show()
	elif not d_buff:
		$JacquesHud/Icons/Defense.hide()
	if d_debuff:
		$JacquesHud/Icons/Defense_D.show()
	elif not d_debuff:
		$JacquesHud/Icons/Defense_D.hide()
	if current_type == "neutral":
		$JacquesHud/Icons/Type.hide()
	if current_type == "fire":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 0
	if current_type == "water":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 1
	if current_type == "air":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 4
	if current_type == "earth":
		$JacquesHud/Icons/Type.show()
		$JacquesHud/Icons/Type.frame = 5
		
func irina_statuses():
	if stun:
		$IrinaHud/Icons/Stun.show()
	elif not stun:
		$IrinaHud/Icons/Stun.hide()
	if poison:
		$IrinaHud/Icons/Poison.show()
	elif not poison:
		$IrinaHud/Icons/Poison.hide()
	if anxious:
		$IrinaHud/Icons/Anxious.show()
	elif not anxious:
		$IrinaHud/Icons/Anxious.hide()
	if wimpy:
		$IrinaHud/Icons/Wimpy.show()
	elif not wimpy:
		$IrinaHud/Icons/Wimpy.hide()
	if dizzy:
		$IrinaHud/Icons/Dizzy.show()
	elif not dizzy:
		$IrinaHud/Icons/Dizzy.hide()
	if targeted:
		$IrinaHud/Icons/Targeted.show()
	elif not targeted:
		$IrinaHud/Icons/Targeted.hide()
	if a_buff:
		$IrinaHud/Icons/Attack.show()
	elif not a_buff:
		$IrinaHud/Icons/Attack.hide()
	if a_debuff:
		$IrinaHud/Icons/Attack_D.show()
	elif not a_debuff:
		$IrinaHud/Icons/Attack_D.hide()
	if m_buff:
		$IrinaHud/Icons/Magic.show()
	elif not m_buff:
		$IrinaHud/Icons/Magic.hide()
	if m_debuff:
		$IrinaHud/Icons/Magic_D.show()
	elif not m_debuff:
		$IrinaHud/Icons/Magic_D.hide()
	if d_buff:
		$IrinaHud/Icons/Defense.show()
	elif not d_buff:
		$IrinaHud/Icons/Defense.hide()
	if d_debuff:
		$IrinaHud/Icons/Defense_D.show()
	elif not d_debuff:
		$IrinaHud/Icons/Defense_D.hide()
	if current_type == "neutral":
		$IrinaHud/Icons/Type.hide()
	if current_type == "fire":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 0
	if current_type == "water":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 1
	if current_type == "air":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 4
	if current_type == "earth":
		$IrinaHud/Icons/Type.show()
		$IrinaHud/Icons/Type.frame = 5
		
func suzy_statuses():
	if stun:
		$SuzyHud/Icons/Stun.show()
	elif not stun:
		$SuzyHud/Icons/Stun.hide()
	if poison:
		$SuzyHud/Icons/Poison.show()
	elif not poison:
		$SuzyHud/Icons/Poison.hide()
	if anxious:
		$SuzyHud/Icons/Anxious.show()
	elif not anxious:
		$SuzyHud/Icons/Anxious.hide()
	if wimpy:
		$SuzyHud/Icons/Wimpy.show()
	elif not wimpy:
		$SuzyHud/Icons/Wimpy.hide()
	if dizzy:
		$SuzyHud/Icons/Dizzy.show()
	elif not dizzy:
		$SuzyHud/Icons/Dizzy.hide()
	if targeted:
		$SuzyHud/Icons/Targeted.show()
	elif not targeted:
		$SuzyHud/Icons/Targeted.hide()
	if a_buff:
		$SuzyHud/Icons/Attack.show()
	elif not a_buff:
		$SuzyHud/Icons/Attack.hide()
	if a_debuff:
		$SuzyHud/Icons/Attack_D.show()
	elif not a_debuff:
		$SuzyHud/Icons/Attack_D.hide()
	if m_buff:
		$SuzyHud/Icons/Magic.show()
	elif not m_buff:
		$SuzyHud/Icons/Magic.hide()
	if m_debuff:
		$SuzyHud/Icons/Magic_D.show()
	elif not m_debuff:
		$SuzyHud/Icons/Magic_D.hide()
	if d_buff:
		$SuzyHud/Icons/Defense.show()
	elif not d_buff:
		$SuzyHud/Icons/Defense.hide()
	if d_debuff:
		$SuzyHud/Icons/Defense_D.show()
	elif not d_debuff:
		$SuzyHud/Icons/Defense_D.hide()
	if current_type == "neutral":
		$SuzyHud/Icons/Type.hide()
	if current_type == "fire":
		$SuzyHud/Icons/Type.show()
		$SuzyHud/Icons/Type.frame = 0
	if current_type == "water":
		$SuzyHud/Icons/Type.show()
		$SuzyHud/Icons/Type.frame = 1
	if current_type == "air":
		$SuzyHud/Icons/Type.show()
		$SuzyHud/Icons/Type.frame = 4
	if current_type == "earth":
		$SuzyHud/Icons/Type.show()
		$SuzyHud/Icons/Type.frame = 5
		
func damien_statuses():
	if stun:
		$DamienHud/Icons/Stun.show()
	elif not stun:
		$DamienHud/Icons/Stun.hide()
	if poison:
		$DamienHud/Icons/Poison.show()
	elif not poison:
		$DamienHud/Icons/Poison.hide()
	if anxious:
		$DamienHud/Icons/Anxious.show()
	elif not anxious:
		$DamienHud/Icons/Anxious.hide()
	if wimpy:
		$DamienHud/Icons/Wimpy.show()
	elif not wimpy:
		$DamienHud/Icons/Wimpy.hide()
	if dizzy:
		$DamienHud/Icons/Dizzy.show()
	elif not dizzy:
		$DamienHud/Icons/Dizzy.hide()
	if targeted:
		$DamienHud/Icons/Targeted.show()
	elif not targeted:
		$DamienHud/Icons/Targeted.hide()
	if a_buff:
		$DamienHud/Icons/Attack.show()
	elif not a_buff:
		$DamienHud/Icons/Attack.hide()
	if a_debuff:
		$DamienHud/Icons/Attack_D.show()
	elif not a_debuff:
		$DamienHud/Icons/Attack_D.hide()
	if m_buff:
		$DamienHud/Icons/Magic.show()
	elif not m_buff:
		$DamienHud/Icons/Magic.hide()
	if m_debuff:
		$DamienHud/Icons/Magic_D.show()
	elif not m_debuff:
		$DamienHud/Icons/Magic_D.hide()
	if d_buff:
		$DamienHud/Icons/Defense.show()
	elif not d_buff:
		$DamienHud/Icons/Defense.hide()
	if d_debuff:
		$DamienHud/Icons/Defense_D.show()
	elif not d_debuff:
		$DamienHud/Icons/Defense_D.hide()
	if current_type == "neutral":
		$DamienHud/Icons/Type.hide()
	if current_type == "fire":
		$DamienHud/Icons/Type.show()
		$DamienHud/Icons/Type.frame = 0
	if current_type == "water":
		$DamienHud/Icons/Type.show()
		$DamienHud/Icons/Type.frame = 1
	if current_type == "air":
		$DamienHud/Icons/Type.show()
		$DamienHud/Icons/Type.frame = 4
	if current_type == "earth":
		$DamienHud/Icons/Type.show()
		$DamienHud/Icons/Type.frame = 5
		
		
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
		
func suzy_update_heal():
	$SuzyHud/Health.text = str(heal_health) + "/" + str(max_health)
	if heal_health >0:
		$SuzyHud/Dead.hide()
		
func damien_update_heal():
	$DamienHud/Health.text = str(heal_health) + "/" + str(max_health)
	if heal_health >0:
		$DamienHud/Dead.hide()

func initial_health():
	$GaryHud/Health.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
	$JacquesHud/Health.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
	$IrinaHud/Health.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
	$SuzyHud/Health.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
	$DamienHud/Health.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)

func hiding():
	modulate.a = 0.5
	yield(get_tree().create_timer(0.125), "timeout")
	modulate.a = 0

func showing():
	modulate.a = 0.5
	yield(get_tree().create_timer(0.125), "timeout")
	modulate.a = 1
