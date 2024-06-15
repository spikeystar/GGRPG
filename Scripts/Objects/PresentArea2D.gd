extends Area2D

export var item_name : String
export var height = 0

var used = false

func _ready():
	yield(get_tree().create_timer(0.2), "timeout")
	connect("body_entered", self, "_on_body_entered")
	position.y = height

func _physics_process(delta):
	if PlayerManager.jumping:
		$CollisionPolygon2D.set_deferred("disabled", false)
	if not PlayerManager.jumping:
		$CollisionPolygon2D.set_deferred("disabled", true)

func _on_body_entered(body):
	print(body.name)
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not used:
		item_get()
		used = true
		
		
func item_get():
	if not Global.Collected.has(global_position):
		SE.effect("Item_Get")
		Party.add_item_name = item_name
		Party.add_item()
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return

