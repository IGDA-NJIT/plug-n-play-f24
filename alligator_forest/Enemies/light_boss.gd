extends EnemyBase

@export var LEFT = -100.0
@export var RIGHT = 100.0
@export var UP = -100.0
@export var DOWN = 100.0
@onready var rng = RandomNumberGenerator.new()
var newPos : Vector2

func _ready() -> void:
	var vpt = get_viewport_rect()
	LEFT = vpt.position.x
	RIGHT = vpt.size.x
	UP = vpt.position.y
	DOWN = vpt.size.y
	$Light.out_of_light.connect(_on_out_of_light)

func _on_timer_timeout() -> void:
	newPos = Vector2(rng.randf_range(LEFT,RIGHT),rng.randf_range(UP,DOWN))
	var tween = create_tween()
	tween.tween_property(self,"global_position",newPos,$Timer.wait_time).set_trans(Tween.TRANS_CIRC)

func _physics_process(delta: float) -> void:
	position.x = clampf(position.x,LEFT,RIGHT)
	position.y = clampf(position.y,UP,DOWN)

func _on_out_of_light() -> void:
	print("out of light")
