extends Node

var previous_scene : String
var position : Vector2
var direction : Vector2
var height : int

var SceneEnemies = []

var new_file = true

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
