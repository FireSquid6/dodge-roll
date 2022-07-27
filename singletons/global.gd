extends Node


var projectile_container: Node2D = null
var player: Player = null
var world: GameWorld = null
var hud: HUD = null
var camera: TraumaCamera2D = null
var transition: TransitionManager = null
var body_container: Node2D = null
var enemy_container: Node2D = null
var level: Level = null

const save_file = "user://file.save"



func setup_camera():
	camera.setup_self()

