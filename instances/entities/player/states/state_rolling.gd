extends PlayerState


var move
export var roll_spd = 1200
export var roll_time = 0.35
export var invincble_time = 0.45

onready var sprite: Sprite = player.get_node("Sprite")
onready var face: AnimatedSprite = player.get_node("Sprite/Face")
var next_state

var roll_sfx = preload("res://sounds/sfx/dice_roll.wav")


func _enter(args := [Vector2.ZERO]):
	# play sound
	Sound.play_sfx(roll_sfx)
	
	# set invincibility
	player.set_invincible(invincble_time)
	
	# get move
	move = args[0]
	$RollTime.wait_time = roll_time
	$RollTime.start()
	
	face.playing = true
	
	# reroll player weapon
	next_state = "StateMoving"
	player.roll_heat += player.roll_cost
	
	if player.roll_heat > player.max_roll_heat:
		next_state = "StateOverheat"
	
	player.reroll_weapon()
	
	

func _game_logic(delta):
	player.velocity = move * roll_spd
	sprite.rotation_degrees += 1440 * delta


func _on_RollTime_timeout():
	face.playing = false
	machine.change_state(next_state)
