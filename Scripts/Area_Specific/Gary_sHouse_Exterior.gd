extends Node

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
onready var transition = TransitionPlayer.instance()

enum TransitionType {
	FADE_TO_BLACK = 0,
}
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name

func _ready():
	SceneManager.SceneEnemies = []
	SceneManager.location = "Gary's House"
	if Music.id != "Garys_House":
		Music.switch_songs()
		Music.id = "Garys_House"
		#Music.id = "Cherry_Trail"
		Music.music()
		
	if EventManager.first_save:
		$SaveStarIntro2/CollisionPolygon2D.disabled = true
		$CollisionRoot/DoorwayToCherryTrail1/CollisionPolygon2D.disabled = false
	
func _process(delta):
	if EventManager.first_save:
		$SaveStarIntro2/CollisionPolygon2D.disabled = true
		$CollisionRoot/DoorwayToCherryTrail1/CollisionPolygon2D.disabled = false
	
