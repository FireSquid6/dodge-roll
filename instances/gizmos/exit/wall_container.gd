extends Node2D


func _process(delta):
	if Global.enemies_left <= 0:
		queue_free()
