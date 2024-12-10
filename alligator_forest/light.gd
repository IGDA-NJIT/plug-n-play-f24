extends Node2D
class_name Stormlight

signal out_of_light()

@export var starting_light : float = 100.0
@onready var remaining_light = starting_light
const DRAIN_RATE = 0.5

func set_light(light : float) -> void:
	starting_light = light
	remaining_light = starting_light

func can_drain() -> bool:
	return (remaining_light > 0.0)

func drain_light() -> float:
	remaining_light -= DRAIN_RATE
	remaining_light = clampf(remaining_light,0,starting_light)
	if(remaining_light > 0.0):
		$PointLight2D.texture_scale -= 0.5 / starting_light
		return DRAIN_RATE
	drained()
	return 0.0

func drained() -> void:
	hide()
	out_of_light.emit()
