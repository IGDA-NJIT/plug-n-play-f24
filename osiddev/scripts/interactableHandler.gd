extends Node2D

var fruit := 0:
	set(value):
		fruit = value
		updateFruit()
var currNum := 0

@onready var birds = [$birds,$birds2,$birds3]

#enables the respective bird area (only one bird area active at a time based on amount of fruit used)
func updateNum(num):
	currNum = num
	if currNum < 3:
		birds[currNum].set_deferred("monitoring",true)

#shows fruit on player
func updateFruit():
	for i in range(1,4):
		if i <= fruit:
			%Player/fruits.get_node(str("fruit",i)).visible = true
		else:
			%Player/fruits.get_node(str("fruit",i)).visible = false
