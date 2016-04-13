
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)

func move_to_pos(new_x, new_y, time):
	var new_x
	var new_y
	var time
	
	
	
	
func _process(delta):
	get_node("Node2D/Navigation2D").move_to(Vector2(0, 0).linear_interpolate(Vector2(5,5), 3))


func _on_button_quit_pressed():
	# Quit the game
	get_tree().quit()
	


func _on_button_start_pressed():
	# Start a new game
	get_node("/root/global").goto_scene("res://intro.scn")
