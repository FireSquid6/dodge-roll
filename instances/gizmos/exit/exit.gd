extends Node2D


export(PackedScene) var next_level = null


func _on_ExitArea_body_entered(body):
	Global.transition.goto_scene(next_level)
