extends Node2D


func _ready():
	Global.projectile_container = $Projectiles


func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
