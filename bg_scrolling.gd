
extends Node2D

export var speed = 50

func _ready():
	set_process(true)

func _process(delta):
	# Sliding Background
	var bg_pos = self.get_pos()
	var screen_width = get_parent().get_viewport_rect().size.width
	
	bg_pos.x -= speed * delta
	set_pos(bg_pos)
	
	if bg_pos.x < -(screen_width):
		self.set_pos(Vector2(screen_width, bg_pos.y))
