
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var parser = get_node("master").get_bbcode()
	get_node("container").set_bbcode(parser)
	pass


