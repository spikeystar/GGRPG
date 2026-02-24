extends YSort

export var ground_enemy : bool

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
export var target_scene : PackedScene
export var alt_scene : PackedScene
export var alt_chance : int
export var alternate : bool
var alt_chosen = false
var alt_not_chosen = false

var freeze = PlayerManager.freeze
onready var battle_arena = target_scene.instance()
onready var alt_arena = alt_scene.instance()

onready var motion_root: KinematicBody2D = $MotionRoot

var motion_root_z

export var dead = false

export var miniboss : bool
export var boss : bool

var killed = false

func _ready():
	$MotionRoot/BattleTrigger.ground_enemy = ground_enemy
	motion_root_z = motion_root.pos_z
	yield(get_tree().create_timer(0.01), "timeout")
	SceneManager.SceneEnemies.append(self)

func _physics_process(delta):
	
	if Global.battle_ended:
		#after_battle()
		Music.unpause()
		SceneManager.SceneEnemies = []
		if $MotionRoot/BattleTrigger.detected and alt_chosen and not killed:
			#get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(alt_arena)
			
			var path = get_tree().get_root().get_node("WorldRoot/Camera2D").get_node(str(alt_arena))
			path.queue_free()
			killed = true
			
		if $MotionRoot/BattleTrigger.detected and not alternate and not killed:
			#get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(battle_arena)
			
			var path = get_tree().get_root().get_node("WorldRoot/Camera2D").get_node(str(battle_arena))
			path.queue_free()
			killed = true
			
		if $MotionRoot/BattleTrigger.detected and alt_not_chosen and not killed:
			#get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(battle_arena)
			
			var path = get_tree().get_root().get_node("WorldRoot/Camera2D").get_node(str(battle_arena))
			path.queue_free()
			killed = true
			
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")
		dead = true
		Global.battle_ended = false
		Global.battling = false
		
		if $MotionRoot/BattleTrigger.detected:
			self.queue_free()
		else:
			SceneManager.SceneEnemies.append(self)
			
		#yield(get_tree().create_timer(0.6), "timeout")
		PlayerManager.pop_2()
		
func after_battle():
	self.hide()
	#$MotionRoot/CollisionShape2D.disabled = true
	#$MotionRoot/PlayerDetection/CollisionShape2D.disabled = true
	#$MotionRoot/BattleTrigger/CollisionShape2D2.disabled = true
	#$BodyYSort/BodyVisualRoot/Enemy.hide()
	#$ShadowYSort/ShadowVisualRoot/ShadowCircle.hide()
	
func _on_BattleTrigger_triggered():
	killed = false
	Music.pause()
	if miniboss:
		BattleMusic.id = "Miniboss_Battle"
	elif boss:
		BattleMusic.id = "Boss_Battle"
	else:
		BattleMusic.id = "Standard_Battle"
	BattleMusic.music()
	Global.battling = true
	get_tree().paused = true
	if alternate:
		randomize()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var chance = rng.randi_range(1, 100)
		if chance <= alt_chance:
			print("alternate")
			alt_chosen = true
			var transition = TransitionPlayer.instance()
			get_tree().get_root().add_child(transition)
			transition.transition()
			yield(get_tree().create_timer(1), "timeout")
			transition.queue_free()
			get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(alt_arena)
		else:
			alt_not_chosen = true
			var transition = TransitionPlayer.instance()
			get_tree().get_root().add_child(transition)
			transition.transition()
			yield(get_tree().create_timer(1), "timeout")
			transition.queue_free()
			get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(battle_arena)
	if not alternate:
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.transition()
		yield(get_tree().create_timer(1), "timeout")
		transition.queue_free()
		get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(battle_arena)
