extends Label

@onready var time = 15
@onready var use_milliseconds = true
@onready var start = true

@export var endoflevel:PackedScene

var frenchOut = 0
var once = false
var once1 = false
var count = 0

func _ready() -> void:
	%DialogueBox.start("start")

func _process(delta : float) -> void:
	if frenchOut >= 5 && once == false && time >= 0:
		var leave = endoflevel.instantiate()
		get_tree().root.get_node("Level").call_deferred("add_child",leave)
		leave.position = Vector2(60,530)
		once = true
	if start:
		time -= delta
		text = _format_seconds(time, use_milliseconds)
		
	if time < 0 and once1 == false:
		%lose.visible = true
		%DialogueBox.start("lose")
		once1 = true

func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)

	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]

	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func _on_french_out_body_entered(body: Node2D) -> void:
		if body is RigidBody2D:
			frenchOut += 1


func _on_dialogue_box_dialogue_ended() -> void:
	if count == 1:
		%Spike.position.y += 700
	count +=1
	
	
