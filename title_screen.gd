
extends Node

var menu_select

func _ready():
	menu_select = "none"
	set_process(true)
	self.get_node("StreamPlayer").play()

func outtro_animation():
	self.get_node("title_animation").play_backwards("title_logo_anim")
	self.get_node("StreamPlayer/music_fader").play("music_fadeout")

func scene_changer(menu_select):
	if self.get_node("title_animation").get_current_animation() == "title_logo_anim" && menu_select == "start":
		get_node("/root/global").goto_scene("res://intro.scn")
	elif self.get_node("title_animation").get_current_animation() == "title_logo_anim" && menu_select == "exit":
		get_tree().quit()

func _on_button_start_pressed():
	menu_select = "start"
	outtro_animation()

func _on_button_quit_pressed():
	menu_select = "exit"
	outtro_animation()

func _on_title_animation_finished():
	scene_changer(menu_select)
