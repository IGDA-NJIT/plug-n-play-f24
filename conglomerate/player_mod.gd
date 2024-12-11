extends Player

##MY ADDITIONS BEGIN
##Dash velocity x and y should create an arch.
@export var dashX: float = 10
@export var dashY: float = 5
@export var dashMax: float = 1
@export var friction: float = .1
##MY ADDITIONS END

##MY ADDITIONS BEGIN
var dashCheck: float =1#0 means no more dash.
##MY ADDITIONS END

## This method is called on the first frame that the Player is active in the scene tree, and by default
## does not do anything. Feel free to override this method if you need to execute any code on the first
## frame.
func _ready():
	current_health = starting_health
	footstep_time = footstep_max_time
	dashCheck = clamp(dashCheck,0,dashMax) 


## This method is called every frame of the game (separate from _physics_process) and by default does not
## do anything. Feel free to overrice this method if you need to execute any code every frame separate from
## the physics engine.
func _process(_delta):
	pass


## This method is called every update of the Godot physics engine, so all physics adjacent computations
## and function calls should be done in this method. You are free to override this function and develop
## your own implementation of player control and movement if you want.
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
	
	##MY ADDITIONS BEGIN
	
	if Input.is_action_just_pressed("player_input_1") and canDash() and Input.is_action_pressed("player_up"):
		sound_player.play_sound(jump_sound, global_position)
		upDash(direction,delta)
		dashCheck-=1
		
	if Input.is_action_just_pressed("player_input_1") and canDash():
		sound_player.play_sound(jump_sound, global_position)
		dash(direction,delta)
		dashCheck-=1
	
	resetDash()
	##MY ADDITIONS END
	
	# Apply gravity if the player is not grounded
	if !is_on_floor():
		apply_gravity(delta)
	
	# Update the player's animation
	update_animation()
	
	# Call this function to move the player based on all modifications to the player's velocity
	move_and_slide()


## Takes a horizontal input value and calculates player horizontal movement accordingly. This 
## function automatically handles acceleration and deceleration of the player when there is/isn't
## user input respectively
func move_horizontal(input: float, delta: float) -> void:
	if abs(input) < INPUT_THRESHOLD * 5 and abs(velocity.x) > 0:
		velocity.x += -sign(velocity.x) * deceleration * delta
		if abs(velocity.x) < STOP_VELOCITY_THRSHOLD:
			velocity.x = 0
	elif abs(velocity.x) < max_horizontal_speed:
		velocity.x += input * acceleration * delta
		if abs(velocity.x) > max_horizontal_speed:
			velocity.x = sign(input) * max_horizontal_speed


## Call this function to execute a jump. By default this function sets the player's vertical velocity
## to the jump_strength value to simulate an upward impulse
func jump() -> void:
	velocity.y = -jump_strength


## This function is called to both apply the gravitational acceleration to the player and clamp the 
## player's gravitational acceleration to their maximum fall speed.
func apply_gravity(delta: float) -> void:
	# Not a necessary optimization but only apply gravity if the player's fall speed is not at its maximum
	if velocity.y < max_fall_speed:
		velocity.y += delta * gravity
		
		# Clamp the player's velocity to this lower bound
		if velocity.y > max_fall_speed:
			velocity.y = max_fall_speed


## This function is called to check if the player is able to jump. By default this is true if the 
## player is grounded, but this function can be overridden to give the player controller unique jump
## behavior without modifying the player's _process function. For example, double jumping can be implemented
## by allowing the player to jump once in the air. A counter can be used to track how many times
## the player has jumped while not grounded, and this can return true when that counter is 0 (or some
## other arbitrary value depending on how many jumps the player is allowed before needing to land).
func can_jump() -> bool:
	return is_on_floor()


## The default damage method for the player. Simply subtracts the amount from the
## player's current health.
func damage(amount: float) -> void:
	sound_player.play_sound(hit_sound, global_position) # Assume when this is being called we are taking damage
	current_health -= amount
	current_health = clampf(current_health, 0, max_health)
	check_death()


## The function that is called to check if the player has died and perform the correct
## functionality
func check_death() -> void:
	if current_health <= 0.0:
		print_rich("[color=pink]Player has died")
		level_loader.reload_level()


## This function is given to the player under the assumption that the player can deal
## contact damage to the enemies somehow (i.e. jumping on the enemy).
func get_source_damage() -> float:
	sound_player.play_sound(hit_sound, global_position) # Assume when this is being called we are dealing damage
	return contact_damage

##MY ADDITIONS BEGIN
func dash(input: float, _delta: float)->void:
	velocity.y = -dashY
	velocity.x = sign(input) * dashX

func upDash(input: float, _delta: float)->void:
	velocity.y = -dashX
	velocity.x = sign(input) * dashY


func canDash()->bool:
	if(dashCheck == 0):
		return false
	else:
		return true


func resetDash()-> void:
	if(is_on_floor()):
		dashCheck = dashMax

##MY ADDITIONS END

## Updates the animation state of the player.
func update_animation() -> void:
	if (!is_on_floor()):
		anim_player.play("JUMP")
	else:
		if abs(velocity.x) < STOP_VELOCITY_THRSHOLD:
			anim_player.play("IDLE")
		else:
			anim_player.play("WALK")
			
	sprite.flip_h = true if sign(velocity.x) < 0 else (false if sign(velocity.x) > 0  else sprite.flip_h)
