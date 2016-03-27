
extends Control

export var health_max = 100
var health = null
export var insanity = 0
export var sick = false

export var starvation_damage = 2

func _ready():
	
	health = health_max
	
	self.get_node("health").set_max(health_max)
	self.get_node("health").set_value(health)
	



func _on_Timer_timeout():
	self.get_node("health").set_value(health)
	
	pass # replace with function body
