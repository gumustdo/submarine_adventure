
extends Sprite

var anim_player
var global
var next_scene

func _ready():
	next_scene = null
	global = get_node("/root/global")
	anim_player = self.get_node("AnimationPlayer")
	# Make the scene fade in on start
	self.show()
	self.get_node("AnimationPlayer").play("fadein")
	

func fade_to_scene(scene):
	self.show()
	self.get_node("AnimationPlayer").play("fadeout")
	next_scene = scene

func change_scene(scene):
	if anim_player.get_current_animation() == "fadeout":
		global.goto_scene("res://" + scene + ".scn")
		print("changing scene")
	elif anim_player.get_current_animation() == "fadein":
		self.hide()

func _on_AnimationPlayer_finished():
	change_scene(next_scene)


