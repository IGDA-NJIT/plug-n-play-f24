extends Node2D
class_name Checkpoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("NotClaimed")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		$AnimatedSprite2D.play("Claimed")
