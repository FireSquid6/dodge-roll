extends Area2D


onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var enemy: Enemy = get_parent().get_parent()

func _physics_process(delta):
	# move at the player
	var shape = collision_shape.shape as SegmentShape2D
	shape.a = enemy.global_position
	shape.b = Global.player.global_position
	
	# set length towards the player
	if Input.is_action_just_pressed("pain"):
		breakpoint
	print("For object " + name)
	print("My pos: " + str(global_position))
	print("Player pos: " + str(Global.player.global_position))
	print("\n")
