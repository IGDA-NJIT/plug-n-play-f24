##IMPORTANT NOTE!!! Hi Sebastian :)
##This is an extended script of the main level.gd script
##I did this so I could manage the player's current stormlight and change the Progress Bar
extends Level
var latestCheckpoint : Checkpoint = null
@export var label : PackedScene
func _ready() -> void:
	super._ready()
	$PlayerFollowCamera/ProgressBar.max_value = %Player.max_stormlight
	$Player/StormRadius.area_entered.connect(_on_player_area_entered)
	print(latestCheckpoint)
	if(latestCheckpoint != null):
		%Player.position = latestCheckpoint.position

func _on_player_change_stormlight(light : int):
	var tween = create_tween()
	tween.tween_property($PlayerFollowCamera/ProgressBar,"value",light,0.5)

func _on_player_cannot_reverse_gravity() -> void:
	var l = label.instantiate()
	add_child(l)
	l.position = %Player.position

func _on_player_area_entered(area : Area2D) -> void:
	if area.get_parent() is Checkpoint:
		latestCheckpoint = area.get_parent()
		print(latestCheckpoint)
