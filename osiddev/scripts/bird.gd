extends Node2D

#randomizes the animation of each individiual bird
func _ready() -> void:
	$AnimationPlayer.speed_scale = 20
	await get_tree().create_timer(randf_range(0,.5)).timeout
	$AnimationPlayer.speed_scale = 1
