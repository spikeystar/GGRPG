extends Node

var id : String

func effect():
	if id == "Item_Get":
		$Item_Get.play()
