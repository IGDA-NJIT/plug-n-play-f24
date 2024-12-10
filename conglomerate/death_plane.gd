extends Area2D
@onready var PlayerRef = $"res://DONOTEDITME/game/player/"

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_hitbox_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_hitbox_entered(other: Area2D):
	# Ignore player hitboxes, player hitboxes should not cause damage
	if other is PlayerHitbox:
		level_loader.reload_level()
	if other is EnemyHitbox:
		return
	
