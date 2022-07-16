extends PlayerState


var move
export var roll_spd = 1200


func _enter(args := [Vector2.ZERO]):
	# get move
	move = args[0]
	
	# start roll timer and set collision mask
	player.set_collision_layer_bit(2, false)
	$RollTime.start()
	
	player.get_node("Polygon2D").color = Color(1, 0, 0)


func _game_logic(delta):
	player.velocity = move * roll_spd


func _exit(args := []):
	# set collision mask back
	player.set_collision_layer_bit(2, false)
	
	player.get_node("Polygon2D").color = Color(1, 1, 1)


func _on_RollTime_timeout():
	machine.change_state("StateMoving")
