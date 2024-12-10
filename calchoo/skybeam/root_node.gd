extends Node3D

var fuckyou = [
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-1.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-2.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-3.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-4.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-5.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-6.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-7.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-8.mp3"),
	load("res://calchoo/skybeam/audio/writing sounds/calvin-scribble-9.mp3"),
]

var pages = [
	load("res://calchoo/skybeam/assets/pages/page1.jpg"),
	load("res://calchoo/skybeam/assets/pages/page2.jpg"),
	load("res://calchoo/skybeam/assets/pages/page3.jpg"),
	load("res://calchoo/skybeam/assets/pages/page4.jpg"),
	load("res://calchoo/skybeam/assets/pages/page5.jpg"),
	load("res://calchoo/skybeam/assets/pages/page6.jpg"),
	load("res://calchoo/skybeam/assets/pages/page7.jpg"),
	load("res://calchoo/skybeam/assets/pages/page8.jpg"),
	load("res://calchoo/skybeam/assets/pages/page9.jpg"),
	load("res://calchoo/skybeam/assets/pages/page10.jpg"),
	load("res://calchoo/skybeam/assets/pages/page11.jpg"),
	load("res://calchoo/skybeam/assets/pages/page12.jpg"),
	load("res://calchoo/skybeam/assets/pages/page13.jpg"),
	load("res://calchoo/skybeam/assets/pages/page14.jpg"),
	load("res://calchoo/skybeam/assets/pages/page15.jpg"),
	load("res://calchoo/skybeam/assets/pages/page16.jpg"),
	load("res://calchoo/skybeam/assets/pages/page17.jpg"),
	load("res://calchoo/skybeam/assets/pages/page18.jpg"),
	load("res://calchoo/skybeam/assets/pages/page19.jpg"),
	load("res://calchoo/skybeam/assets/pages/page20.jpg"),
	load("res://calchoo/skybeam/assets/pages/page21.jpg"),
	load("res://calchoo/skybeam/assets/pages/page22.jpg"),
	load("res://calchoo/skybeam/assets/pages/page23.jpg"),
	load("res://calchoo/skybeam/assets/pages/page24.jpg"),
	load("res://calchoo/skybeam/assets/pages/page25.jpg"),
	load("res://calchoo/skybeam/assets/pages/page26.jpg"),
	load("res://calchoo/skybeam/assets/pages/page27.jpg"),
	load("res://calchoo/skybeam/assets/pages/page28.jpg"),
	load("res://calchoo/skybeam/assets/pages/page29.jpg"),
	load("res://calchoo/skybeam/assets/pages/page30.jpg"),
	load("res://calchoo/skybeam/assets/pages/page31.jpg"),
	load("res://calchoo/skybeam/assets/pages/page32.jpg"),
	load("res://calchoo/skybeam/assets/pages/page33.jpg"),
	load("res://calchoo/skybeam/assets/pages/page34.jpg"),
	load("res://calchoo/skybeam/assets/pages/page35.jpg"),
	load("res://calchoo/skybeam/assets/pages/page36.jpg"),
	load("res://calchoo/skybeam/assets/pages/page37.jpg"),
	load("res://calchoo/skybeam/assets/pages/page38.jpg"),
	load("res://calchoo/skybeam/assets/pages/page39.jpg"),
	load("res://calchoo/skybeam/assets/pages/page40.jpg"),
	load("res://calchoo/skybeam/assets/pages/page41.jpg"),
	load("res://calchoo/skybeam/assets/pages/page42.jpg"),
	load("res://calchoo/skybeam/assets/pages/page43.jpg"),
	load("res://calchoo/skybeam/assets/pages/page44.jpg"),
	load("res://calchoo/skybeam/assets/pages/page45.jpg"),
	load("res://calchoo/skybeam/assets/pages/page46.jpg"),
	load("res://calchoo/skybeam/assets/pages/page47.jpg"),
	load("res://calchoo/skybeam/assets/pages/page48.jpg"),
	load("res://calchoo/skybeam/assets/pages/page49.jpg"),
	load("res://calchoo/skybeam/assets/pages/page50.jpg"),
	load("res://calchoo/skybeam/assets/pages/page51.jpg"),
	load("res://calchoo/skybeam/assets/pages/page52.jpg"),
	load("res://calchoo/skybeam/assets/pages/page53.jpg"),
	load("res://calchoo/skybeam/assets/pages/page54.jpg"),
	load("res://calchoo/skybeam/assets/pages/page55.jpg"),
	load("res://calchoo/skybeam/assets/pages/page56.jpg"),
	load("res://calchoo/skybeam/assets/pages/page57.jpg"),
	load("res://calchoo/skybeam/assets/pages/page58.jpg"),
	load("res://calchoo/skybeam/assets/pages/page59.jpg"),
	load("res://calchoo/skybeam/assets/pages/page60.jpg"),
	load("res://calchoo/skybeam/assets/pages/page61.jpg"),
	load("res://calchoo/skybeam/assets/pages/page62.jpg"),
	load("res://calchoo/skybeam/assets/pages/page63.jpg"),
	load("res://calchoo/skybeam/assets/pages/page64.jpg"),
	load("res://calchoo/skybeam/assets/pages/page65.jpg"),
	load("res://calchoo/skybeam/assets/pages/page66.jpg"),
	load("res://calchoo/skybeam/assets/pages/page67.jpg"),
	load("res://calchoo/skybeam/assets/pages/page68.jpg"),
	load("res://calchoo/skybeam/assets/pages/page69.jpg"),
]

var jamin = false
var writen = 0
@export var endoflevel:PackedScene
var once = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if jamin and Input.is_action_just_pressed("player_input_1") and %pageshow.visible == false:
		for i in range(3):
			$sfx.stream = fuckyou[randi()%9]
			$sfx.play()
			await $sfx.finished
		%pageshow.texture = pages[randi()%69]
		%pageshow.visible = true
		$sfx.stream = load("res://calchoo/skybeam/audio/pageturn-102978.mp3")
		$sfx.play()
		writen += 1
		%interact.text = "K to close"
		
	if Input.is_action_just_pressed("player_input_2"):
		%pageshow.visible = false
		if jamin:
			%interact.text = "J to write"
		else:
			%interact.text = ""
			
	if writen > 5 and once == false:
		var leave = endoflevel.instantiate()
		get_tree().root.get_node("Level").call_deferred("add_child",leave)
		leave.position = Vector2(800,500)
		once = true
		
		
		
		
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.global_position += Vector2(1600,0)


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	body.global_position -= Vector2(1600,0)


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	%interact.text = "J to write"
	jamin = true


func _on_area_2d_3_body_exited(body: Node2D) -> void:
	if %interact == null:
		jamin = false
		return
	%interact.text = ""
	jamin = false
