extends "res://DONOTEDITME/game/system/level.gd"

var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	camera = $PlayerFollowCamera

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
