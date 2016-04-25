
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_button_back_pressed():
	self.get_node("scene_fader").fade_to_scene("landmark_menu")
