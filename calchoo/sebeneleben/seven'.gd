extends Sprite2D

var inside = false
var entered = false
var once = false
var mik = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("player_input_1"):
		if  entered:
			if !once:
				%DialogueBox.start("1")
				once = true
			goin()
		if mik:
			%DialogueBox.start("mik")
	if entered:
		if inside == false:
			%interact.text = "J to enter"
		if inside == true:
			%interact.text = "J to exit"
	
func goin():
	if inside == false:
		%cam.position += Vector3(0,0,2.2)
		$wall1/co1.set_deferred("disabled",false)
		$wall1/co2.set_deferred("disabled",false)
		$wall1/co4.set_deferred("disabled",false)
		$wall1/co5.set_deferred("disabled",false)
		$firemusic.attenuation = 1
		inside = true
	elif inside == true:
		%cam.position -= Vector3(0,0,2.2)
		$wall1/co1.set_deferred("disabled",true)
		$wall1/co2.set_deferred("disabled",true)
		$wall1/co4.set_deferred("disabled",true)
		$wall1/co5.set_deferred("disabled",true)
		$firemusic.attenuation = 16
		inside = false


func _on_door_body_entered(_body: Node2D) -> void:
	entered = true
		
	


func _on_door_body_exited(_body: Node2D) -> void:
	if %interact == null:
		return
	entered = false
	
	%interact.text = ""


func _on_topleave_body_exited(body: Node2D) -> void:
	if body is Player:
		if body.velocity.y > 0:
			goin()
		if body.velocity.y < 0:
			goin()
		

func _on_miku_body_entered(_body: Node2D) -> void:
	mik = true
	%interact.text = "J to talk"
	
	


func _on_miku_body_exited(_body: Node2D) -> void:
	mik = false
	%interact.text = ""
