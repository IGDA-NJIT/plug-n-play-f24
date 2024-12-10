extends Node
class_name WorldSelector

const OFF_POS = Vector3(0, 0, 20)

@export_category("Cartridge Visual References")
@export var cartridge_models: Array[Node3D]
@export var left_pos: Node3D
@export var right_pos: Node3D
@export var center_pos: Node3D
@export var offscreen_left_pos: Node3D
@export var offscreen_right_pos: Node3D

@export_category("Transition Config")
@export var transition_time: float = 1

@export_category("Level References")
@export var levels: Array[Level]

var index = 0
var changeable = true
var curr_tween: Tween

func change_index(d: int) -> int:
	var idx = index
	
	while d < 0:
		d += 1
		idx -= 1
		if idx < 0:
			idx = len(cartridge_models) - 1
		
	while d > 0:
		d -= 1
		idx += 1
		if idx >= len(cartridge_models):
			idx = 0
	
	print(idx)
	return idx


func _ready() -> void:
	for i in cartridge_models:
		i.position = OFF_POS
	
	var l = cartridge_models[change_index(-1)]
	var r = cartridge_models[change_index(1)]
	var c = cartridge_models[index]
	
	c.position = center_pos.global_position
	l.position = left_pos.global_position
	r.position = right_pos.global_position
	

func _process(delta: float) -> void:
	if changeable:
		if (Input.is_action_just_pressed("player_left")):
			changeable = false
			var rr = cartridge_models[change_index(2)]
			var r = cartridge_models[change_index(1)]
			var c = cartridge_models[index]
			var l = cartridge_models[change_index(-1)]
			rr.position = offscreen_right_pos.global_position
			index = change_index(1)
			
			curr_tween = get_tree().create_tween()
			curr_tween.tween_property(rr, "position", right_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.parallel().tween_property(r, "position", center_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.parallel().tween_property(c, "position", left_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.parallel().tween_property(l, "position", offscreen_left_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.finished.connect(_on_tween_end)
			curr_tween.play()
			
		elif (Input.is_action_just_pressed("player_right")):
			changeable = false
			
			var rr = cartridge_models[change_index(2)]
			var r = cartridge_models[change_index(1)]
			var c = cartridge_models[index]
			var l = cartridge_models[change_index(-1)]
			rr.position = offscreen_right_pos.global_position
			index = change_index(1)
			
			curr_tween = get_tree().create_tween()
			curr_tween.tween_property(rr, "position", right_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.parallel().tween_property(r, "position", center_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.parallel().tween_property(c, "position", left_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.parallel().tween_property(l, "position", offscreen_left_pos.global_position, transition_time).set_trans(Tween.TRANS_SINE)
			curr_tween.finished.connect(_on_tween_end)
			curr_tween.play()
			
		elif (Input.is_action_just_pressed("player_input_1")):
			level_loader.load_level(index)

func _on_tween_end():
	curr_tween.finished.disconnect(_on_tween_end)
	curr_tween = null
	changeable = true
