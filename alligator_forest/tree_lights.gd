extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for l in get_children():
		if l is Stormlight:
			l.out_of_light.connect(_on_light_drained)

func _on_light_drained() -> void:
	for l in get_children():
		if l is Stormlight and l.can_drain():
			return
	print("all the lights are disabled!")
	queue_free()
