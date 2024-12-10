extends WalkingEnemy
class_name LightEnemy

@export var starting_light : = 100.0

func _ready() -> void:
	super._ready()
	$Light.set_light(self.starting_light)
	$Light.out_of_light.connect(_on_light_drained)
	
	if(sign(up_direction.y) > 0):
		jump_strength *= -1
		max_fall_speed *= -1
		gravity *= -1

func _physics_process(delta):
	velocity = Vector2(horizontal_speed * direction, velocity.y)
	# Not a necessary optimization but only apply gravity if the player's fall speed is not at its maximum
	if(up_direction.y == -1):
		if velocity.y < max_fall_speed:
			velocity.y += delta * gravity
			
			# Clamp the player's velocity to this lower bound
			if velocity.y > max_fall_speed:
				velocity.y = max_fall_speed
	else:
		if(velocity.y > max_fall_speed):
			velocity.y += delta * gravity
			# Clamp the player's velocity to this lower bound
			if velocity.y < max_fall_speed:
				velocity.y = max_fall_speed
	
	var ground_collider = ground_check.get_collider()
	if (ground_collider == null and is_on_floor()) || (ground_collider is Area2D and (ground_collider as Area2D).get_collision_layer_value(4)):
		change_direction()
	elif wall_check.get_collider() != null and is_on_floor():
		var prob = randf()
		if prob < 0.5:
			change_direction()
		else:
			velocity.y = -jump_strength
	
	if((sign(velocity.x) > 0 and sign(up_direction.y) < 0) or (sign(velocity.x) < 0 and sign(up_direction.y) > 0)):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	#sprite.flip_h = false if (sign(velocity.x) < 0 and up_direction < 0 ||) else (true if sign(velocity.x) > 0  else sprite.flip_h)
	move_and_slide()
	
	# Check animation
	if is_on_floor():
		anim_player.play("WALK")
	else:
		anim_player.play("JUMP")

func _on_light_drained() -> void:
	damage(1)
