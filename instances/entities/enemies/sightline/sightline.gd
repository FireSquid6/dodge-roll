extends Node2D
class_name Sightline


onready var range_checker: Area2D = get_node("RangeChecker")
onready var reflex_timer: Timer = get_node("Reflex")
onready var obstruction_checker: Area2D = get_node("Node/ObstructionChecker")
var reflex = 0.5
var sight_distance = 1024
var player_in_sight = false


signal player_spotted()
signal player_lost()


func _ready():
	# setup nodes
	var range_shape = range_checker.get_node("CollisionShape2D").shape as CircleShape2D
	range_shape.radius = sight_distance
	reflex_timer.wait_time = reflex


func _physics_process(delta):
	# MOVE
	global_rotation = 0
	
	# CHECK
	# check if the player is in range
	var in_range = false
	for body in range_checker.get_overlapping_bodies():
		if body as Player:
			in_range = true
	
	# check if there are obstructions in the way
	var obstructed = (len(obstruction_checker.get_overlapping_bodies()) > 0)
	
	# SIGNAL
	if in_range and !obstructed:
		if reflex_timer.is_stopped() and !player_in_sight:
			reflex_timer.start()
	elif player_in_sight:
		player_in_sight = false
		emit_signal("player_lost")
		if !reflex_timer.is_stopped():
			reflex_timer.stop()


func _on_Reflex_timeout():
	player_in_sight = true
	emit_signal("player_spotted")
