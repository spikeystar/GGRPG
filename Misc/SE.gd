extends Node

func silence(id : String):
	if id == "Move Between":
		$Move_Between.volume_db = -80
		yield(get_tree().create_timer(0.2), "timeout")
		$Move_Between.volume_db = 1
	if id == "Select":
		$Select.volume_db = -80
		yield(get_tree().create_timer(0.3), "timeout")
		$Select.volume_db = -4
	if id == "Extend":
		$Extend.volume_db = -80
		yield(get_tree().create_timer(4), "timeout")
		$Extend.volume_db = -1
	if id == "Metal Door":
		$Metal_Door.volume_db = -80
		yield(get_tree().create_timer(0.3), "timeout")
		$Metal_Door.volume_db = -4
		
func mega_silence(id : String):
	if id == "Move Between":
		yield(get_tree().create_timer(0.2), "timeout")
		$Move_Between.volume_db = -80

func effect(id : String):
	if id == "Item_Get":
		$Item_Get.play()
	if id == "Sleep":
		$Sleep.play()
	if id == "Present":
		$Present.play()
	if id == "Full Heal":
		$Full_Heal.play()
	if id == "Boss Death":
		$Boss_Death.play()
	if id == "Bouncy":
		$Bouncy.play()
	if id == "Bubble Enter":
		$Bubble_Enter.play()
	if id == "Bubble Pop":
		$Bubble_Pop.play()
	if id == "Buff":
		$Buff.play()
	if id == "Cancel":
		$Cancel.play()
	if id == "Chest":
		$Chest.play()
	if id == "Debuff":
		$Debuff.play()
	if id == "Defend":
		$Defend.play()
	if id == "Door":
		$Door.play()
	if id == "Drama Ascend":
		$Drama_Ascend.play()
	if id == "Drama Blast":
		$Drama_Blast.play()
	if id == "Drama Descend":
		$Drama_Descend.play()
	if id == "Drama Flash":
		$Drama_Flash.play()
	if id == "Drama Jump":
		$Drama_Jump.play()
	if id == "Drama Land":
		$Drama_Land.play()
	if id == "Drama Shock":
		$Drama_Shock.play()
	if id == "Drama Thud":
		$Drama_Thud.play()
	if id == "Drown 2":
		$Drown_2.play()
	if id == "Drown":
		$Drown.play()
	if id == "Enemy Death":
		$Enemy_Death.play()
	if id == "Fall":
		$Fall.play()
	if id == "Flee":
		$Flee.play()
	if id == "Game Over":
		$Game_Over.play()
	if id == "Heal":
		$Heal.play()
	if id == "Item Shop":
		$Item_Shop.play()
	if id == "Item Use":
		$Item_Use.play()
	if id == "Jewel Seeds":
		$Jewel_Seeds.play()
	if id == "Jump":
		$Jump.play()
	if id == "Marble":
		$Marble.play()
	if id == "Menu Close":
		$Menu_Close.play()
	if id == "Menu Open":
		$Menu_Open.play()
	if id == "Metal Door":
		$Metal_Door.play()
	if id == "Move Between":
		$Move_Between.play()
	if id == "Ouch":
		$Ouch.play()
	if id == "Party Joined":
		$Party_Joined.play()
	if id == "Player Death":
		$Player_Death.play()
	if id == "Poof":
		$Poof.play()
	if id == "Revive":
		$Revive.play()
	if id == "Save Star":
		$Save_Star.play()
	if id == "Select":
		$Select.play()
	if id == "Staircase":
		$Staircase.play()
	if id == "Success":
		$Success.play()
	if id == "Switch":
		$Switch.play()
	if id == "Unable":
		$Unable.play()
	if id == "Whammy!":
		$Whammy.play()
	if id == "Jammed":
		$Jammed.play()
	if id == "Jammed2":
		$Jammed2.play()
	if id == "Handle":
		$Handle.play()
	if id == "Extend":
		$Extend.play()
	if id == "Grab":
		$Grab.play()
	if id == "Win":
		$Win.play()
	if id == "Fail":
		$Fail.play()
	if id == "Alien_Spawn":
		$Alien_Spawn.play()
	if id == "Alien_Death":
		$Alien_Death.play()
	if id == "Alien_Triumph":
		$Alien_Triumph.play()
	if id == "Pew":
		$Pew.play()
	if id == "UFO":
		$UFO.play()
	if id == "Explosive":
		$Explosive.play()
	if id == "Countdown":
		$Countdown.play()
	if id == "Countdown2":
		$Countdown2.play()
	if id == "Water_Gun":
		$Water_Gun.play()
	if id == "Pressed":
		$Pressed.play()
		
		
#######################################################
	if id == "Barrage":
		$Barrage.play()
	if id == "Basic":
		$Basic.play()
	if id == "Beat Down":
		$Beat_Down.play()
	if id == "Splat":
		$Splat.play()
	if id == "Precious Beam":
		$Precious_Beam.play()
	if id == "Aero Bullet":
		$Aero_Bullet.play()
	if id == "Asphyxiate":
		$Asphyxiate.play()
	if id == "Bubble Ring":
		$Bubble_Ring.play()
	if id == "Earthslide":
		$Earthslide.play()
	if id == "Extort":
		$Extort.play()
	if id == "Friction":
		$Friction.play()
	if id == "Gravel Spat":
		$Gravel_Spat.play()
	if id == "Icicle":
		$Icicle.play()
	if id == "Pester":
		$Pester.play()
	if id == "Prism Snow":
		$Prism_Snow.play()
	if id == "Red Fender":
		$Red_Fender.play()
	if id == "Sabotage":
		$Sabotage.play()
	if id == "Skateboard":
		$Skateboard.play()
	if id == "Slash":
		$Slash.play()
	if id == "Squall":
		$Squall.play()
	if id == "Star Wand":
		$Star_Wand.play()
	if id == "Sting":
		$Sting.play()
	if id == "Stream Strike":
		$Stream_Strike.play()
	if id == "Sweet Gift":
		$Sweet_Gift.play()
	if id == "Terra Arrow":
		$Terra_Arrow.play()
	if id == "Thunderstorm":
		$Thunderstorm.play()
	if id == "Zap":
		$Zap.play()
