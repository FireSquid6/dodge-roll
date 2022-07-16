extends PlayerState


export var extra_reduction = 40


func _game_logic(delta):
	player.roll_heat -= extra_reduction * delta
	player.velocity = Vector2.ZERO


func _transition_logic(states := []):
	if player.roll_heat <= 0:
		machine.change_state("StateMoving")


func _enter(args := []):
	Sound.play_sfx(preload("res://sounds/sfx/glass_break.wav"))
	player.roll_heat = player.max_roll_heat
	
	player.sprite.modulate = Color("B4D2E7")
	Global.camera.add_trauma(0.75)


func _exit(args := []):
	player.sprite.modulate = Color(1, 1, 1, 1)
