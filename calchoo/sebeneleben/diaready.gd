extends Control

@onready var audio_player = $sf
var miku = load("res://calchoo/sebeneleben/audio/mikudayo.wav")
var jam = load("res://calchoo/sebeneleben/audio/lilguynoise.wav")
var french = load("res://calchoo/francedefance/audio/Snort_ (Spy Voice Lines).mp3")
var dialogue_button = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%DialogueBox.custom_effects[0].char_displayed.connect(_on_char_displayed)
	dialogue_button = %DialogueBox.get_children()[0].get_children()[0].get_children()[1].get_children()[2].get_children()[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not get_tree().paused:
		dialogue_button.grab_focus()


func _on_char_displayed(idx):
	# you can use the idx parameter to check the index of the character displayed
	if %DialogueBox.speaker_label.text == "Jammy":
		audio_player.volume_db = -10
		audio_player.pitch_scale = randf_range(0.8,1.3)
		audio_player.stream = jam
		audio_player.play()
		
	if %DialogueBox.speaker_label.text == "Hatsune Miku":
		audio_player.volume_db = 0
		audio_player.pitch_scale = randf_range(0.9,1.1)
		audio_player.stream = miku
		audio_player.play()
		
	if %DialogueBox.speaker_label.text == "Frenchmen":
		audio_player.volume_db = 0
		audio_player.pitch_scale = randf_range(0.7,1.0)
		audio_player.stream = french
		audio_player.play()
