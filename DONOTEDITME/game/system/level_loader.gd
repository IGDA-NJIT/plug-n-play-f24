extends Node
## This class is designed to be a singleton object for loading and reloading levels.
## The most important takeaway from this class is the reload level function which 
## reloads/restarts the level. This is called when you press "restart" in the pause menu
## and at the end of the default kill screen animation. YOU DO NOT NEED TO MODIFY THIS CLASS
class_name LevelLoader

const LEVEL_END_TIME: float = 1

@export var main_menu_scene: PackedScene
@export var world_map_scene: PackedScene
@export var level_array: Array[PackedScene]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var level_loaded: int = -1
var loading = false
var reloading = false

## Call this function to reload the scene
func reload_level() -> void:
	get_tree().paused = true
	reloading = true
	animation_player.play("CLOSE")


## Method stub for me to implement later when stringing all the levels together
func load_level(index: int) -> void:
	get_tree().paused = true
	loading = true
	level_loaded = index
	animation_player.play("CLOSE")


## This method is called when a level is ended
func end_level() -> void:
	get_tree().paused = true
	sound_player.unload_music_stream()
	level_loaded = -1
	
	sound_player.play_sound(load("res://DONOTEDITME/assets/sounds/sfx/win_fx.ogg"), Vector2(0, 0))
	var end_timer = get_tree().create_timer(LEVEL_END_TIME)
	end_timer.timeout.connect(level_end_timer_end)


func level_end_timer_end() -> void:
	animation_player.play("CLOSE")


func _on_animation_finished(anim_name):
	if anim_name == "CLOSE":
		if reloading:
			var _reload = get_tree().reload_current_scene()
			reloading = false
		elif loading:
			var level = null
			if level_loaded < 0:
				level = world_map_scene.instantiate()
			else:
				level = level_array[level_loaded].instantiate()
			get_tree().current_scene.queue_free()
			level.tree_entered.connect(_on_enter_tree.bind(level))
			get_tree().root.call_deferred("add_child", level)
			animation_player.play("OPEN")
		else:
			get_tree().paused = false
			sound_player.update_sound_nosettings()
			var main_menu = main_menu_scene.instantiate()
			main_menu.tree_entered.connect(_on_enter_tree.bind(main_menu))
			get_tree().current_scene.queue_free()
			get_tree().root.call_deferred("add_child", main_menu)


func _on_enter_tree(scene):
	get_tree().current_scene = scene
	animation_player.play("OPEN")
	get_tree().paused = false
	if loading:
		sound_player.load_music_stream(scene.music_stream)
		loading = false
	


func _on_scene_loaded(level: Level):
	get_tree().paused = false
	animation_player.play("OPEN")


func load_selector():
	get_tree().paused = true
	loading = true
	level_loaded = -1
	animation_player.play("CLOSE")
