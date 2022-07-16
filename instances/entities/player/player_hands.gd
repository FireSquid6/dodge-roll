extends Sprite


onready var spawn_position


func _process(delta):
	spawn_position = $Position2D.global_position
	global_rotation = global_position.angle_to_point(get_global_mouse_position())
	global_rotation -= PI / 2
