extends Node2D
class_name Level


var enemies_left = 0
var score = 0
var multiplier = 1
var multiplier_timer := Timer.new()
var mode = MODES.CAMPAIGN

export var next_scene: PackedScene = null
onready var level_time: Timer = get_node("LevelTime")


enum MODES {
	CAMPAIGN
	ENDLESS
}


signal enemy_killed(enemy)
signal mode_chosen(mode)


func _enter_tree():
	# connect signals
	connect("enemy_killed", self, "_on_Global_enemy_killed")
	
	# setup multiplier timer
	add_child(multiplier_timer)
	multiplier_timer.wait_time = 2
	multiplier_timer.one_shot = true
	multiplier_timer.connect("timeout", self, "multiplier_timer_timeout")
	
	# give the global object various references
	Global.projectile_container = $Projectiles
	Global.body_container = $Bodies
	Global.enemy_container = $Entities/Enemies
	Global.level = self
	
	# this is a bad solution to setting a mode and will need to be fixed later
	# I should probably be using inheritance
	mode = MODES.CAMPAIGN
	if name == "Endless":
		mode = MODES.ENDLESS
	
	emit_signal("mode_chosen", mode)


# start the timer
func _ready():
	if mode == MODES.CAMPAIGN:
		level_time.start()


func multiplier_timer_timeout():
	multiplier = 1


func _on_Global_enemy_killed():
	enemies_left -= 1
	score += 10 * multiplier
	
	multiplier += 1
	multiplier = clamp(multiplier, 1, 10)
	multiplier_timer.start()
	
	if enemies_left < 1 and mode == MODES.CAMPAIGN:
		Global.player.hud.notification_label.visible = true
		Global.player.hud.notification_label.bbcode_text = "Level complete. Press [color=yellow]E[/color] to move on."
		level_time.paused = true


func _process(delta):
	# pause if neccessary
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
	
	# move to next level
	if Input.is_action_just_pressed("interact") and enemies_left <= 0 and mode == MODES.CAMPAIGN:
		Global.transition.goto_scene(next_scene)


func _on_LevelTime_timeout():
	Global.player.die()
