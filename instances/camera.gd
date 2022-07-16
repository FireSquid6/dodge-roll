extends Camera2D


func _process(delta):
	var mouse_offset = (get_viewport().get_mouse_position() - get_viewport().size / 2)
	position = lerp(Vector2(), mouse_offset.normalized() * 500, mouse_offset.length() / 1000)
