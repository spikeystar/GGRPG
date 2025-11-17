extends PathFollow2D

var speed = 120
var dead = false
	
func _process(delta):
	
	if SceneManager.score >= 200:
		speed = 140
		
	if SceneManager.score >= 400:
		speed = 160
	
	if not SceneManager.win and not dead:
		set_offset(get_offset() + speed * delta)
		
	if get_child_count() >0:
		var child = get_children()
		child[0].global_position = global_position
		dead = child[0].dead
		
		
