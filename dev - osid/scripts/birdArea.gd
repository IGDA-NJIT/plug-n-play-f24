extends Area2D

@export var num := 0

@onready var sfx = preload("res://dev - osid/src/audio/fx/bird.wav")

#sets one bird area active at a time
func _ready() -> void:
	if num == 0:
		monitoring = true

func _on_body_entered(body: Node2D) -> void:
	sound_player.play_sound(sfx,position)
	#checks for fruit and removes itself if present
	if get_parent().fruit > 0:
		set_deferred("monitoring", false)
		$bird/AnimatedSprite2D/Sprite2D.visible = true
		var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self, "position", Vector2(position.x,-1000), 2)
		get_parent().updateNum(num+1)
		get_parent().fruit -= 1
	#if no fruit, pushes player until they're out of the area
	if monitoring:
		while get_overlapping_bodies().size() > 0:
			body.velocity.x += 100
			await get_tree().create_timer(.1).timeout
