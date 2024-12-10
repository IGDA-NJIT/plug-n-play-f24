extends Player

func _physics_process(delta: float) -> void:
	if !%DialogueBox.visible:
		super._physics_process(delta)
