extends Node


var projectile_container: Node2D = null
var player: Player = null
var world: GameWorld = null
var hud: HUD = null
var camera: TraumaCamera2D = null
var transition: TransitionManager = null
var body_container: Node2D = null


signal enemy_killed(enemy)


func setup_camera():
	camera.setup_self()
