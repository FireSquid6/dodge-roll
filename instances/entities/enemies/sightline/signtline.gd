extends Node2D


onready var range_checker: Area2D = get_node("RangeChecker")
onready var reflex_timer: Timer = get_node("Reflex")
onready var obstruction_checker: Area2D = get_node("Node/ObstructionChecker")
export var reflex = 0.5
export var sight_distance = 1024

func _ready():
	# setup nodes
	var range_shape = range_checker.get_node("CollisionShape2D").shape as CircleShape2D
	range_shape.radius = sight_distance


func _physics_process(delta):
	# MOVE
	global_rotation = 0
	var parent = get_parent()
	var obstruction_shape: SegmentShape2D = obstruction_checker.get_node("CollisionShape2D").shape
	obstruction_shape.a = parent.position
	obstruction_shape.b = Global.player.global_position
	
	print("My parent is: " + get_parent().name)
	print("He lives at: " + str(get_parent().global_position))
	print("However, for some fucking reason I'm at " + str(obstruction_shape.a))
	
	# CHECK
	# check if the player is in range
	var in_range = false
	for body in range_checker.get_overlapping_bodies():
		if body as Player:
			in_range = true
	
	# check if there are obstructions in the way
	
