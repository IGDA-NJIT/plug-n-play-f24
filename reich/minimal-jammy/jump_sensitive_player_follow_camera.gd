@tool
extends "res://DONOTEDITME/game/player/player_follow_camera.gd"

const UPPER_THRESHOLD = -120
const LOWER_THRESHOLD = 30
enum mode {UPPER_FOCUS = -100, LOWER_FOCUS = 100, CENTER_FOCUS = 0}
var current_mode

func _ready():
	set_focus_upper()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = %Player.global_position.x
	
	var dif = %Player.global_position.y - position.y
	
	if(
		( dif < UPPER_THRESHOLD and %Player.is_on_floor() ) or
		( dif > LOWER_THRESHOLD ) 
	):
		position.y = %Player.global_position.y
	queue_redraw()

func set_focus_mode(new_mode: mode):
	var offset_tween  = get_tree().create_tween()
	current_mode = new_mode
	offset_tween.tween_property($".", "offset", Vector2(0, current_mode), 3).set_trans(Tween.TRANS_QUAD)

func set_focus_upper():
	set_focus_mode(mode.UPPER_FOCUS)
	
func set_focus_lower():
	set_focus_mode(mode.LOWER_FOCUS)
	
func set_focus_center():
	set_focus_mode(mode.CENTER_FOCUS)
