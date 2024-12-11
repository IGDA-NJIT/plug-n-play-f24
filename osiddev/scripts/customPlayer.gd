extends Player

#allows jumping down from a branch
func _process(_delta):
	if Input.is_action_just_pressed("player_down"):
		collision_mask = 0
		await get_tree().create_timer(.2).timeout
		collision_mask = 2

#adjust fruit position
func update_animation() -> void:
	super.update_animation()
	if velocity.x != 0:
		$fruits.position.x = sign(velocity.x) * abs($fruits.position.x)
		for child in $fruits.get_children():
			child.position.x = -sign(velocity.x) * abs(child.position.x)
			child.flip_h = $Sprite2D.flip_h

#the stopping threshhold was giving the player weird behaviors so I overrode it
func move_horizontal(input: float, delta: float) -> void:
	if abs(input) < INPUT_THRESHOLD and abs(velocity.x) > 0:
		velocity.x += -sign(velocity.x) * deceleration * delta
		if abs(velocity.x) < 10:
			velocity.x = 0
	elif abs(velocity.x) < max_horizontal_speed:
		velocity.x += input * acceleration * delta
		if abs(velocity.x) > max_horizontal_speed:
			velocity.x = sign(input) * max_horizontal_speed
