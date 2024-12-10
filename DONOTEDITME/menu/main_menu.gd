extends CanvasLayer
### The script responsible for main menu stuff
class_name MainMenu


# Main Menu Buttons
@onready var play_button: Button = $Main/VBoxContainer/PlayButton
@onready var settings_button: Button = $Main/VBoxContainer/SettingsButton

# Settings Buttons
@onready var settings_return_button: Button = $Settings/SettingsReturnButton

# Animation player
@onready var menu_anim_player: AnimationPlayer = $MenuTransitionAnimationPlayer

# Credits Buttons
@onready var credits_return_button: Button = $Credits/CreditsReturnButton
@onready var credits_button: Button = $Main/VBoxContainer/CreditsButton

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_settings_pressed():
	menu_anim_player.play("SETTINGS")
	settings_return_button.grab_focus()


func _on_credits_pressed():
	menu_anim_player.play("CREDITS")
	credits_return_button.grab_focus()


func _on_credits_return_pressed():
	menu_anim_player.play_backwards("CREDITS")
	credits_button.grab_focus()


func _on_play_pressed():
	level_loader.load_selector()


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_return_pressed():
	menu_anim_player.play_backwards("SETTINGS")
	settings_button.grab_focus()
