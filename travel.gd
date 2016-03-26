
extends Node2D

export var distance = 200 # Distance for testing 
var distance_per_turn = 50 # Temporaly speed
var distance_left = null
var food_consumption = 10
var fuel_consumption = 2

# Player's Resources
var food = 200
var fuel = 1000
var spare_part = 50
var first_aid = 3
var morphine = 2
var torpedo = 2
var harpoon = 100
var gold = 120

var random_index = null # Blank random number slot for event


func _ready():
	distance_left = distance
	
	self.set_process(true)
	# Assign values to UI text
	get_node("ui/Panel/distance_left_title/distance_left_value").set_text(str(distance))
	get_node("ui/Panel/fuel_title/fuel_left").set_text(str(fuel))
	get_node("ui/Panel/food_title/food_left").set_text(str(food))
	
	get_node("ui/Panel/distance_left_title/ProgressBar").set_max(distance)
	
func _process(delta):
	
	# Sliding Background
	var bg_pos = self.get_node("bg_set_1").get_pos()
	bg_pos.x -= 100 * delta
	get_node("bg_set_1").set_pos(bg_pos)
	
	# Wrappinng Background around the scene
	var screen_width = self.get_viewport_rect().size.width
	if get_node("bg_set_1").get_pos().x < -(screen_width):
		get_node("bg_set_1").set_pos(Vector2(screen_width, 0))

func _travel():
	print("traveling")
	get_node("ui/Panel/distance_left_title/ProgressBar").set_value(distance - distance_left)


func _on_Timer_timeout():
	if fuel > 0 :
		self._travel()
	else:
		get_tree().set_pause(true)
		get_node("random_event/Label").set_text("You are out of fuel")
		get_node("random_event/RichTextLabel").add_text("With out fuel you and your crew can't go anywhere")
		get_node("random_event").show()
		
		
	# Test random event
	var random_index = randi() % 100
	print("random outcome : " + str(random_index))
	
	if random_index > 80:
		get_tree().set_pause(true)
		get_node("random_event").show()
	
	# Distance deduction and displaying result
	var distance_update = get_node("ui/Panel/distance_left_title/distance_left_value")
	var fuel_left = get_node("ui/Panel/fuel_title/fuel_left")
	var food_left = get_node("ui/Panel/food_title/food_left")
	
	distance_update.set_text(str(distance_left))
	# get_node("ui/Panel/distance_left_title/ProgressBar").
	
	fuel_left.set_text(str(fuel))
	food_left.set_text(str(food))
	
	distance_left -= distance_per_turn
	fuel -= fuel_consumption
	food -= food_consumption
	


func _on_Button_pressed():
	# Closing text msg will unpause the game
	get_tree().set_pause(false)
	get_node("random_event").hide()
	
