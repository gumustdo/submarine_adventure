
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"


func _on_button_continue_pressed():
	get_node("scene_fader").fade_to_scene("landmark_menu")
	print("Ouch!")
