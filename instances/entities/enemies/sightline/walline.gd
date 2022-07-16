extends Area2D


onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func _physics_process(delta):
	# angle towards the player
	global_rotation = global_position.angle_to_point(Global.player.global_position)
	
	# set length towards the player
	collision_shape.shape.length = global_position.distance_to(Global.player.position)
