extends Node

var previous_scene : String
var position : Vector2
var direction : Vector2
var height : int

var SceneEnemies = []

var loading = false
var saving = false
var overworld = false

var location : String
var npc_name : String
var ready_again = false
var victory = false
var game_over = false
var targeted_applied = false
var flee = false
var counter : int = 0
var bubble = false
var enemy_repel = false
var enemy_turn = false
var transitioning = false
var minigame_done = false
var event_start = false
var current_time : int

var time_decided = false
var day = false
var night = false

var attack_fortune = false
var magic_fortune = false
var defense_fortune = false
var whammy_fortune = false
var fortune_counter = 0

var win = false

var score = 0
var ammo_b = false
var ammo_c = false

var comfy_blanket = false
var stress_ball = false
var lucky_locket = false
var beggars_amulet = false
var bottlecap = false
var flashlight = false
var compass = false
var cloud_shroud = false
var white_flag = false
var antique_watch = false
var shiny_watch = false
var megaphone = false
var super_cape = false
var flower_crown = false
var crux_name = ""

## DEBUG ##
var times = 0
