extends Node2D

#offsets animation for waves and position
func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	$Timer2.start()

#animates the waves
func _on_timer_timeout() -> void:
	$waterA/water1.visible = !$waterA/water1.visible
	$waterA/water2.visible = !$waterA/water2.visible
	$waterB/water1.visible = !$waterB/water1.visible
	$waterB/water2.visible = !$waterB/water2.visible

var movement = [-2,-1,0,1,2,1,0,-1]
var aCounter = 0
var bCounter = 4

#animates the position
func _on_timer_2_timeout() -> void:
	$waterA.position.y = movement[aCounter % movement.size()]
	$waterB.position.y = movement[bCounter % movement.size()]
	aCounter += 1
	bCounter += 1
