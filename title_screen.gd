
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_button_quit_pressed():
	# Quit the game
	get_tree().quit()
	


func _on_button_start_pressed():
	# Start a new game
	get_node("/root/global").goto_scene("res://intro.scn")
