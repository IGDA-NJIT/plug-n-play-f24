extends Label

var opacity : float = 1.0

func _process(delta: float) -> void:
	position.y -= 1

func _on_timer_timeout() -> void:
	queue_free()
