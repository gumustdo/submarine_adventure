extends Node

var player_name
var crew1_name
var crew2_name
var crew3_name

# custom node variables
var button_accept
var button_start
var dialog_box
var input_player_name

func _ready():
	
	# Assign nodes to variable for easier calls
	button_accept = get_node("dialogue_bg/input_player_name/button_accept")
	button_start = get_node("button_start")
	dialog_box = get_node("dialogue_bg/RichTextLabel")
	input_player_name = get_node("dialogue_bg/input_player_name")
	
	#Hide the accept button if player haven't input the name yet
	button_accept.hide()
	button_start.hide()

	set_process(true)
	
func _process(delta):

	#If there's character in the name field. enable accept button.
	if input_player_name.get_text().length() != 0:
		button_accept.show()
	else:
		button_accept.hide()




func _on_button_accept_pressed():
	get_node("intro_scene_anim").play("dialog_fadeout_anim")
	

func _on_button_start_pressed():
	get_node("/root/global").goto_scene("res://travel.scn")

func _on_dialog_fadeout_anim_finished():
	get_node("/root/global").player.name = input_player_name.get_text()
	dialog_box.clear()
	dialog_box.add_text("Thank you, " + get_node("/root/global").player.name + " Now let's begin talking about your story shall we?")
	print("name input done")
	get_node("intro_scene_anim").play("dialog_fade_in")
	input_player_name.hide()
	button_start.show()
