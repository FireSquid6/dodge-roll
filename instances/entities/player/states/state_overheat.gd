extends PlayerState


export var extra_reduction = 20


func _game_logic(delta):
	player.roll_heat -= extra_reduction * delta


func _transition_logic(states := []):
	if player.roll_heat <= 0:
		machine.change_state("StateMoving")


func _enter(args := []):
	player.roll_heat = player.max_roll_heat
