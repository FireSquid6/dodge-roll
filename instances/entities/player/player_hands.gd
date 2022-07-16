extends Polygon2D


func _process(delta):
	global_rotation = global_position.angle_to_point(get_global_mouse_position())
	global_rotation -= PI / 2
