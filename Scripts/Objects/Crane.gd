extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func chain_extend():
		yield(get_tree().create_timer(0.2), "timeout")
		$Chains.show()
		$Chains/Chain1.show()
		yield(get_tree().create_timer(0.4), "timeout")
		$Chains/Chain2.show()
		
