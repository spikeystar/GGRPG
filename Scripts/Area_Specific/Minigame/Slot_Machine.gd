extends Node2D

var wagering = false
var able = false
var done = false
var current_wager : int = 1000
var cooldown = false

var slot_1 = false
var slot_2 = false
var slot_3 = false

func _ready():
	$Slots/Slot1.frame = 0
	$Slots/Slot2.frame = 5
	$Slots/Slot3.frame = 2
	SE.effect("Menu Open")
	$AnimationPlayer.play("open")
	yield(get_tree().create_timer(0.8), "timeout")
	wagering = true
	
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

func _input(event):
	if Input.is_action_just_pressed("ui_up") and wagering and current_wager < 10000 and not cooldown:
		cooldown = true
		SE.effect("Marble")
		current_wager += 1000
		$Title.text = "Wager: " + str(thousands_sep(current_wager))
		yield(get_tree().create_timer(0.2), "timeout")
		cooldown = false
		
	if Input.is_action_just_pressed("ui_down") and wagering and current_wager > 1000 and not cooldown:
		cooldown = true
		SE.effect("Marble")
		current_wager -= 1000
		$Title.text = "Wager: " + str(thousands_sep(current_wager))
		yield(get_tree().create_timer(0.2), "timeout")
		cooldown = false
		
	if Input.is_action_just_pressed("ui_up") and wagering and current_wager == 10000 and not cooldown:
		cooldown = true
		SE.effect("Unable")
		yield(get_tree().create_timer(0.2), "timeout")
		cooldown = false
		
	if Input.is_action_just_pressed("ui_down") and wagering and current_wager == 1000 and not cooldown:
		cooldown = true
		SE.effect("Unable")
		yield(get_tree().create_timer(0.2), "timeout")
		cooldown = false
		
	if Input.is_action_just_pressed("ui_select") and wagering and Party.marbles < current_wager:
		SE.effect("Unable")
		
	if Input.is_action_just_pressed("ui_select") and wagering and Party.marbles >= current_wager:
		wagering = false
		SE.effect("Switch")
		yield(get_tree().create_timer(0.5), "timeout")
		SE.effect("Metal Door")
		able = true
		$Slots/Slot1.playing = true
		$Slots/Slot2.playing = true
		$Slots/Slot3.playing = true
	
	if Input.is_action_just_pressed("ui_select") and able and not slot_1:
		able = false
		cooldown = true
		SE.effect("Switch")
		SE.effect("Metal Door")
		$Slots/Slot1.playing = false
		yield(get_tree().create_timer(0.5), "timeout")
		slot_1 = true
		cooldown = false
		
	if Input.is_action_just_pressed("ui_select") and slot_1 and not slot_2 and not cooldown:
		cooldown = true
		SE.effect("Switch")
		SE.effect("Metal Door")
		$Slots/Slot2.playing = false
		yield(get_tree().create_timer(0.5), "timeout")
		slot_2 = true
		cooldown = false
		
	if Input.is_action_just_pressed("ui_select") and slot_1 and slot_2 and not slot_3 and not cooldown:
		cooldown = true
		SE.effect("Switch")
		SE.effect("Metal Door")
		$Slots/Slot3.playing = false
		yield(get_tree().create_timer(0.5), "timeout")
		slot_3 = true
		results()

		
	if Input.is_action_just_pressed("ui_select") and done:
		done = false
		SE.effect("Menu Open")
		$AnimationPlayer.play_backwards("open")
		$AnimationPlayer.playback_speed = 1
		yield(get_tree().create_timer(0.9), "timeout")
		self.queue_free()
		
		
func results():
	var SlotArray = $Slots.get_children()
	var spade_count = 0
	var diamond_count = 0
	var clover_count = 0
	var star_count = 0
	for x in SlotArray:
		if x.frame == 0 or x.frame == 4:
			spade_count +=1
		if x.frame == 1 or x.frame == 5:
			diamond_count +=1
		if x.frame == 2 or x.frame == 6:
			clover_count +=1
		if x.frame == 3:
			star_count +=1
			
	if spade_count == 3:
		Party.marbles += (current_wager * 2)
		$Notify/Instruction.text = "2X Win!"
		SE.effect("Win")
		
	if diamond_count == 3:
		Party.marbles += (current_wager * 3)
		$Notify/Instruction.text = "3X Win!"
		SE.effect("Win")
		
	if clover_count == 3:
		Party.marbles += (current_wager * 4)
		$Notify/Instruction.text = "4X Win!"
		SE.effect("Win")
		
	if star_count == 3:
		Party.marbles += (current_wager * 5)
		$Notify/Instruction.text = "5X Win!"
		SE.effect("Win")
		
	if spade_count <3 and diamond_count<3 and clover_count<3 and star_count<3:
		$Notify/Instruction.text = "Try Again!"
		SE.effect("Fail")
		
		
	yield(get_tree().create_timer(0.5), "timeout")	
	$Notify/AnimationPlayer.play("open")
	$Notify.show()
	
	yield(get_tree().create_timer(0.5), "timeout")
	done = true
	SceneManager.minigame_done = true
