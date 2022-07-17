extends EnemyState
class_name StateIdle


export var idle_spd = 300
export var reflect_threshold = 200
export(bool) var attack_when_spotted = false
export var spotted_state = ""
export(Array) var spotted_args = []
export var spotted_anim = ""
export var min_time = 1
export var max_time = 3
export var move_dir = Vector2(1, 1)
var moving = false
onready var timer = get_node("Timer")


func _enter(args := []):
	# set bitmask
	enemy.set_collision_mask_bit(4, true)
	print(enemy.collision_mask)
	
	# connect signals
	if !enemy.sightline.is_connected("player_spotted", self, "_on_Sightline_player_spotted"):
		enemy.sightline.connect("player_spotted", self, "_on_Sightline_player_spotted")
	
	# stupid dumb workaround for my stupid dumb code
	if len(args) == 0:
		Sound.play_sfx(preload("res://sounds/sfx/deactivate.wav"))
	
	# setup movement
	timer.wait_time = rand_range(min_time, max_time)
	timer.start()
	
	if (randi() % 100 + 1) <= 50:
		start_moving()


func _exit(args := []):
	# play sound
	Sound.play_sfx(preload("res://sounds/sfx/activate.wav"))
	
	# set bitmask
	enemy.set_collision_mask_bit(4, false)


func _game_logic(delta):
	if moving:
		var velocity = enemy.move_and_slide(idle_spd * move_dir)
		enemy.rotation = move_dir.angle()
		enemy.rotation += PI / 2
		
		if enemy.get_slide_count() > 0 and velocity.length() < reflect_threshold:
			move_dir = move_dir.bounce(enemy.get_slide_collision(0).normal)
			


func start_moving():
	moving = true
	move_dir = Vector2(1, 0).rotated(rand_range(0, TAU))


func _on_Sightline_player_spotted():
	if attack_when_spotted:
		machine.change_state(spotted_state, spotted_args, [])
		if enemy.animation_player:
			enemy.animation_player.play(spotted_anim)


func _on_Timer_timeout():
	if !moving:
		start_moving()
	else:
		moving = false
	
	timer.wait_time = rand_range(min_time, max_time)
	timer.start()
