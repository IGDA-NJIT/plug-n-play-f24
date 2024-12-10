extends RigidBody2D

var interact = false
var picked = false
var dir = false

var jam

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("player_left"):
		dir = true
	if Input.is_action_just_pressed("player_right"):
		dir = false
	
	
	if Input.is_action_just_pressed("player_input_1"):
		if interact:
			picked = true
			var ow = randi()%3
			if ow == 0:
				$yell.set_stream(load("res://dev/francedefance/audio/coward.mp3"))
				$yell.play()
			elif ow == 1:
				$yell.set_stream(load("res://dev/francedefance/audio/disgust.mp3"))
				$yell.play()
			elif ow == 2:
				$yell.set_stream(load("res://dev/francedefance/audio/usuck.mp3"))
				$yell.play()
			
	if Input.is_action_pressed("player_input_2"):
		if picked:
			picked = false
			if dir:
				self.linear_velocity = Vector2(-2000,-1000)
			if !dir:
				self.linear_velocity = Vector2(2000,-1000)
			var ow = randi()%2
			if ow == 0:
				$yell.set_stream(load("res://dev/francedefance/audio/spyscream2.mp3"))
				$yell.play()
			elif ow == 1:
				$yell.set_stream(load("res://dev/francedefance/audio/spyscream1.ogg"))
				$yell.play()
			self.set_collision_mask_value(2,false)
			self.set_collision_mask_value(1,true)
			await get_tree().create_timer(0.5,true).timeout
			self.set_collision_mask_value(2,true)
			
			
	if picked:
		%interact.text = "K to throw"
		if dir:
			self.position = jam.position + Vector2(20,-10)
		if !dir:
			self.position = jam.position + Vector2(-20,-10)
		self.set_collision_mask_value(1,false)
		self.set_collision_mask_value(2,false)

func wait():
	await get_tree().create_timer(5,true).timeout

func _on_area_2d_body_entered(body: Node2D) -> void:
	jam = body
	print(body)
	if body is Player:
		interact = true
		%interact.text = "J to grab"

func _on_area_2d_body_exited(body: Node2D) -> void:
	jam = body
	if body is Player:
		interact = false
		%interact.text = ""
