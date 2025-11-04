extends Player

@export var max_stormlight = 100.0 ##The maximum stormlight Jammy can hold at any given time
@export var starting_stormlight = 0.0 ##The amount of stormlight that Jammy begins each scene with.
@onready var stormlight = starting_stormlight
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal change_light(light : int)
signal cannot_reverse_gravity

var tween : Tween

var draining : bool = true
var nearestLights: Array[Stormlight] = []

func _on_storm_radius_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Stormlight and area.get_parent().can_drain()):
		nearestLights.append(area.get_parent())

func _on_storm_radius_area_exited(area: Area2D) -> void:
	if(area.get_parent() is Stormlight):
		nearestLights.remove_at(nearestLights.find(area.get_parent()))
func _physics_process(delta):
	# Retrieve the horizontal input axis
	var direction = Input.get_axis("player_left", "player_right")
	
	# Set the player's horizontal velocity based on player input
	move_horizontal(direction, delta)
	if (direction != 0 and footstep_time < 0 and is_on_floor()):
		footstep_time = footstep_max_time
		sound_player.play_sound(footstep_sound, global_position)
	else:
		footstep_time -= delta
	
	# Check if the player can jump and execute the jump function if so
	if Input.is_action_just_pressed("player_jump") and can_jump():
		sound_player.play_sound(jump_sound, global_position)
		jump()
	
	# Apply gravity if the player is not grounded
	if !is_on_floor():
		apply_gravity(delta)
	
	# Update the player's animation
	update_animation()
	
	# Call this function to move the player based on all modifications to the player's velocity
	move_and_slide()
	
	change_light.emit(stormlight)
	if(draining):
		for light in nearestLights:
			stormlight += light.drain_light()
	if(stormlight >= max_stormlight):
		draining = false
	else:
		draining = true
	if(sign(up_direction.y) > 0):
		stormlight -= 0.1
		if(stormlight <= 0.0):
			reverse_gravity()
		
	stormlight = clampf(stormlight,0.0,100.0)
	tween = create_tween()
	tween.tween_property($PointLight2D,"energy",stormlight/75 + 0.01,0.5)
	tween.tween_property($PointLight2D,"texture_scale",stormlight/75 + 0.5,0.5)
	#$PointLight2D.energy = stormlight / 100
	#$PointLight2D.texture_scale = stormlight / 100

	if(Input.is_action_just_pressed("player_input_1")):
		if(stormlight >= 20 or sign(up_direction.y) > 0):
			stormlight -= 10
			reverse_gravity()
		else:
			cannot_reverse_gravity.emit()

func reverse_gravity() -> void:
	$Sprite2D.flip_v = !$Sprite2D.flip_v
	up_direction.y *= -1
	jump_strength *= -1
	max_fall_speed *= -1
	gravity *= -1

func apply_gravity(delta: float) -> void:
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
