
extends TextureProgress

var token_submarine
var token_destination
var token_submarine_pos
var token_destination_pos
var tokens_distance

func _ready():
	token_submarine = get_node("token_submarine")
	token_destination = get_node("token_destination")
	token_submarine_pos = token_submarine.get_pos()
	token_destination_pos = token_destination.get_pos()
	tokens_distance = token_submarine_pos.distance_to(token_destination_pos)
	
	token_submarine_pos.x = (self.get_value() / self.get_max()) * token_destination_pos.x
	token_submarine.set_pos(token_submarine_pos)

func distance_update():	
	# Update the distance bar
	self.set_value(get_parent().distance - get_parent().distance_left)
	
	# Update submarine token's possition
	token_submarine_pos.x = (self.get_value() / self.get_max()) * token_destination_pos.x
	token_submarine.set_pos(token_submarine_pos)