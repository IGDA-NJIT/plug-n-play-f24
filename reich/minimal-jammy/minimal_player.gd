extends "res://DONOTEDITME/game/player/player_legacy.gd"



func _physics_process(delta):
	super(delta)
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
