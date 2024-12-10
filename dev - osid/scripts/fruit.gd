extends Area2D

@onready var sfx = preload("res://dev - osid/src/audio/fx/pickUp.wav")

#allows fruit to be picked up
func _on_body_entered(_body: Node2D) -> void:
	sound_player.play_sound(sfx,position)
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1,1,1,0), .2)
	get_parent().fruit += 1
	set_deferred("monitoring", false)
