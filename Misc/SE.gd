extends Node

func effect(id : String):
	if id == "Item_Get":
		$Item_Get.play()
	if id == "Sleep":
		$Sleep.play()
	if id == "Present":
		$Present.play()
