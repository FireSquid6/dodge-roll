extends Node2D


func _ready():
	Global.projectile_container = $Projectiles
	Global.body_container = $Bodies
	Global.enemy_container = $Entities/Enemies


func _process(delta):
	# pause if neccessary
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
