extends Area2D

@onready var sfx = preload("res://dev - osid/src/audio/fx/fallWater.wav")

#plays sound when entering water
func _on_body_entered(_body: Node2D) -> void:
	sound_player.play_sound(sfx,%Player.position)
