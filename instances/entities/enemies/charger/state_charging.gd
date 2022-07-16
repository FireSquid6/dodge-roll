extends EnemyState


export var distance_threshold = 96
export var spd = 800


func _on_Sightline_player_lost():
	machine.change_state("StateIdle")


func _game_logic(delta):
	# move
	enemy.look_at_player()
	enemy.move_towards_player(spd)


func _transition_logic(available_states := []):
	# get the distance
	var distance = enemy.position.distance_to(Global.player.position)
	
	if distance <= distance_threshold:
		machine.change_state("StateExploding")
