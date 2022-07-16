extends Node2D
class_name Sightline


onready var range_checker: Area2D = get_node("RangeChecker")
onready var reflex_timer: Timer = get_node("Reflex")
onready var obstruction_checker: Area2D = get_node("Node/ObstructionChecker")
var reflex = 0.5
var sight_distance = 1024

func _ready():
	# setup nodes
	var range_shape = range_checker.get_node("CollisionShape2D").shape as CircleShape2D
	range_shape.radius = sight_distance


func _physics_process(delta):
	# MOVE
	global_rotation = 0
	var obstruction_shape: SegmentShape2D = obstruction_checker.get_node("CollisionShape2D").shape
	print(global_position)
	obstruction_shape.a = global_position
	print(obstruction_shape.a)
	print("\n")
	obstruction_shape.b = Global.player.global_position
	
	# CHECK
	# check if the player is in range
	var in_range = false
	for body in range_checker.get_overlapping_bodies():
		if body as Player:
			in_range = true
	
	# check if there are obstructions in the way
	
