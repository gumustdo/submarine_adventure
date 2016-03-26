
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	self.set_process(true)

func _process(delta):
	var bgPos = self.get_pos()
	bgPos.x -= 100 * delta
	print(bgPos.x)


