
extends Sprite

func _ready():
	self.set_process(true)

func _process(delta):
	var bgPos = self.get_pos()
	bgPos.x -= 100 * delta
	print(bgPos.x)
