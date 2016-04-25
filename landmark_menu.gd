
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_button_shop_pressed():
	self.get_node("scene_fader").fade_to_scene("shop")


func _on_button_leave_pressed():
	self.get_node("scene_fader").fade_to_scene("travel")
