extends Sprite

func _process(delta):
	
	$Location.text = SceneManager.location
	
	if SceneManager.location == "Gary's House":
		$Gary.position = Vector2(-105, -21)
		
	if SceneManager.location == "Cherry Trail":
		$Gary.position = Vector2(-96, 28)
		
	if SceneManager.location == "Pivot Town":
		$Gary.position = Vector2(25, 1)
		
	if SceneManager.location == "Kugi Canyon":
		$Gary.position = Vector2(43, -59)
		
	if SceneManager.location == "Berry Lake":
		$Gary.position = Vector2(102, -48)
		
	if not EventManager.Saguarotel:
		$Marker.show()
		$Marker.position = Vector2(37, -120)
