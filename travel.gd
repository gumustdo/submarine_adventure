
extends Node2D

export var distance = 2400 # Distance for testing 
var distance_per_turn = 50 # Temporaly speed
var distance_left = null
var food_consumption = 10
var fuel_consumption = 2

# Player's Resources
var resource
var global

# flags
var ship_state = "sail"
var food_ran_out = false

# Randomizer
var random_index = null # Blank random number slot for event

func _ready():	
	global = get_node("/root/global")
	resource = get_node("/root/global").resource
	
	distance_left = distance
	
	self.set_process(true)
	# Assign values to UI text
	if global.player.name == null:
		global.player.name = "Carmack"
		get_node("control_panel/crew_1/name").set_text(get_node("/root/global").player.name)
	else:
		get_node("control_panel/crew_1/name").set_text(get_node("/root/global").player.name)
		
	
	get_node("distance_left_title/distance_left_value").set_text(str(distance))
	get_node("control_panel/ship_status/fuel_left").set_text(str(resource.fuel))
	get_node("control_panel/ship_status/food_left").set_text(str(resource.food))
	
	get_node("distance_left_bar").set_max(distance)

func ship_stop():
	get_node("player_container/player_ship/AnimationPlayer").play("stop")
	ship_state = "stop"
	

func out_of_fuel():
	print("You are out of fuel")
	get_tree().set_pause(true)
	get_node("random_event/Label").set_text("You are out of fuel")
	get_node("random_event/RichTextLabel").add_text("With out fuel you and your crew can't go anywhere \nAll you can do is wait or scavange")
	get_node("random_event").show()
	self.ship_stop()
	
func out_of_food():
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
	get_node("ui/control_panel/crew_1").health -= get_node("ui/control_panel/crew_1").starvation_damage
	print(get_node("ui/control_panel/crew_1").health)

func distance_check():
	# Distance deduction and displaying result
	var distance_update = get_node("distance_left_title/distance_left_value")
	distance_update.set_text(str(distance_left))
	distance_left -= distance_per_turn
	
	# When player reached a landmark do this
	if distance_left == 0:
		get_tree().set_pause(true)
		# Max out the distancebar
		self.get_node("distance_left_bar").set_value(self.get_node("distance_left_bar").get_max())
		self.get_node("distance_left_bar").distance_update()
		
		# Signal scene_fader to play fadeout animation and parse the next scene name.
		self.get_node("scene_fader").fade_to_scene("landmark_splash")
		
	
func _on_Timer_timeout():
	if resource.fuel > 0 :
		get_node("distance_left_bar").distance_update()
	else:
		get_node("Timer").stop()
		self.out_of_fuel()
		
	# Test random event
	var random_index = randi() % 100
	print("random outcome : " + str(random_index))
	
	if random_index > 110:
		get_tree().set_pause(true)
		get_node("random_event").show()
	
	distance_check()
	var fuel_left = get_node("control_panel/ship_status/fuel_left")
	var food_left = get_node("control_panel/ship_status/food_left")
	
	fuel_left.set_text(str(resource.fuel))
	food_left.set_text(str(resource.food))
	
	# Stat check
	resource.fuel -= fuel_consumption
	
	if resource.food < 0 :
		resource.food = 0
	
	if resource.food > 0 :
		resource.food -= food_consumption
		food_ran_out = false
	elif resource.food == 0 and food_ran_out == false:
		food_ran_out = true
		self.out_of_food()
		
	print("food run out? " + str(food_ran_out))

func _on_Button_pressed():
	# Closing text msg will unpause the game
	get_tree().set_pause(false)
	get_node("random_event").hide()
