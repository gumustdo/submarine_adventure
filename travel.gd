
extends Node2D

export var distance = 200 # Distance for testing 
var distance_per_turn = 50 # Temporaly speed
var distance_left = null
var food_consumption = 10
var fuel_consumption = 2

# Player's Resources
export var food = 200
export var fuel = 10
var spare_part = 50
var first_aid = 3
var morphine = 2
var torpedo = 2
var harpoon = 100
var gold = 120

var ship_state = "sail"

var food_ran_out = false


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
	if ship_state == "sail":
		bg_pos.x -= 100 * delta
		get_node("bg_set_1").set_pos(bg_pos)
	elif ship_state == "stop":
		get_node("bg_set_1").set_pos(bg_pos)
	
	# Wrappinng Background around the scene
	var screen_width = self.get_viewport_rect().size.width
	if get_node("bg_set_1").get_pos().x < -(screen_width):
		get_node("bg_set_1").set_pos(Vector2(screen_width, 0))

func _travel():
	print("traveling")
	get_node("ui/Panel/distance_left_title/ProgressBar").set_value(distance - distance_left)

func _ship_stop():
	get_node("player_container/player_ship/AnimationPlayer").play("stop")
	ship_state = "stop"
	

func _out_of_fuel():
	print("You are out of fuel")
	get_tree().set_pause(true)
	get_node("random_event/Label").set_text("You are out of fuel")
	get_node("random_event/RichTextLabel").add_text("With out fuel you and your crew can't go anywhere \nAll you can do is wait or scavange")
	get_node("random_event").show()
	self._ship_stop()
	
func _out_of_food():
	if food_ran_out:	
		print("You are out of food")
		get_node("random_event/Label").set_text("You are out of Food")
		get_node("random_event/RichTextLabel").clear()
		get_node("random_event/RichTextLabel").add_text("With out fuel you and your crew can't go anywhere \nAll you can do is wait or scavange")
		get_node("random_event").show()
		food_ran_out = false
		get_tree().set_pause(true)
	else:
		pass	
	
	# Damage
	get_node("ui/Panel/crew_1").health -= get_node("ui/Panel/crew_1").starvation_damage
	print(get_node("ui/Panel/crew_1").health)
	
func _on_Timer_timeout():
	if fuel > 0 :
		self._travel()
	else:
		get_node("Timer").stop()
		self._out_of_fuel()
		
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
	
	# Stat check
	distance_left -= distance_per_turn
	fuel -= fuel_consumption
	
	if food < 0 :
		food = 0
	
	if food > 0 :
		food -= food_consumption
		food_ran_out = false
	elif food == 0 and food_ran_out == false:
		food_ran_out = true
		self._out_of_food()
		
	print("food run out? " + str(food_ran_out))

func _on_Button_pressed():
	# Closing text msg will unpause the game
	get_tree().set_pause(false)
	get_node("random_event").hide()
	
