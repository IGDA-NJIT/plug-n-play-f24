extends Label

@onready var time = 0
@onready var use_milliseconds = true
@onready var start = true

@export var endoflevel:PackedScene
var once = false

func _ready() -> void:
	%DialogueBox.start("start")

func _process(delta : float) -> void:
	if time >= 120 && once == false:
		var leave = endoflevel.instantiate()
		get_tree().root.get_node("Level").call_deferred("add_child",leave)
		leave.position = Vector2(225,355)
		once = true
	if start:
		time += delta
		text = _format_seconds(time, use_milliseconds)

func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)

	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]

	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
