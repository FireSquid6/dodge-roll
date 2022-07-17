extends Node


var projectile_container: Node2D = null
var player: Player = null
var world: GameWorld = null
var hud: HUD = null
var camera: TraumaCamera2D = null
var transition = null
var body_container: Node2D = null
var enemy_container: Node2D = null

var enemies_left = 0
var score = 0
var multiplier = 1
var multiplier_timer := Timer.new()
var mode = MODES.CAMPAIGN

enum MODES {
	CAMPAIGN
	ENDLESS
}


signal enemy_killed(enemy)
signal mode_chosen(mode)


func _ready():
	connect("enemy_killed", self, "_on_Global_enemy_killed")
	add_child(multiplier_timer)
	multiplier_timer.wait_time = 5
	multiplier_timer.one_shot = true
	multiplier_timer.connect("timeout", self, "multiplayer_timer_timeout")


func multiplier_timer_timeout():
	multiplier = 1


func _on_Global_enemy_killed():
	enemies_left -= 1
	score += 50 * multiplier


func setup_camera():
	camera.setup_self()


func set_mode(new_mode):
	mode = new_mode
	emit_signal("mode_chosen")
