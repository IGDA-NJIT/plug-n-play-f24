extends Node2D

#animates the light beams
func _ready() -> void:
	var startPos = position
	var dir = 1
	await get_tree().create_timer(randf_range(0,5)).timeout
	while true:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self, "position", startPos + Vector2(dir*5,0), 5)
		await get_tree().create_timer(5).timeout
		dir *= -1
