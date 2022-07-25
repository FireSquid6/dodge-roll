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
var save

const save_file = "user://file.save"



func setup_camera():
	camera.setup_self()


func _enter_tree():
	# load save file
	var file = File.new()
	OS.shell_open(ProjectSettings.globalize_path("user://"))
	if file.file_exists(save_file):
		file.open(save_file, File.READ)
		save = file.get_var(true)
		file.close()
	else:
		save = Save.new()


func _exit_tree():
	# save self
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_var(save)
	file.close()
	
