extends Sprite


onready var spawn_position


func _process(delta):
	spawn_position = $Position2D.global_position
	global_rotation = global_position.angle_to_point(Cursor.real_position)
	global_rotation -= PI / 2
