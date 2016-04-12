extends RichTextLabel

var text_length = null
var i = 0
var skip = false

func type_text():
	skip = false
	text_length = self.get_bbcode().length()
	self.set_visible_characters(0)

func _ready():
	type_text()

func _on_Timer_timeout():
		
	if i < text_length && skip == false:
		self.set_visible_characters(i)
		# Allow skipping by click
		if Input.is_action_pressed("skip_text"):
			self.set_visible_characters(text_length)
			skip = true
		
		i += 1
