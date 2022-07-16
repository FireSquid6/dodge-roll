extends PlayerState


export var max_spd = 1200
export var accspd = 18000
var can_roll = false
var move = Vector2.ZERO


func _game_logic(delta):
	# update the player's gun
	player.update_weapon()
	
	# get movement inputs
	move = Vector2(int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")), int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")))
	
	# if inputs have been pressed
	if move.length() > 0:
		# accelerate
		move = move.normalized()
		
		# get the distance
		var distance = player.velocity.length()
		distance += (accspd * delta)
		
		if distance > max_spd:
			distance = max_spd
		
		# set the velocity
		player.velocity = move * distance
	else:
		# check if snapping to 0 is neccessary
		if player.velocity.length() <= (accspd * delta):
			player.velocity = Vector2(0, 0)
		else:
			# otherwise, just decelerate
			var angle = player.velocity.angle()
			var new_length = player.velocity.length() - (accspd * delta)
			
			player.velocity = Vector2(new_length, 0).rotated(angle)


func _transition_logic(existing_states := []):
	if can_roll and Input.is_action_just_pressed("roll") and move.length() > 0:
		# transition to rolling
		machine.change_state("StateRolling", [move], [])


func _enter(args := []):
	# start the roll cooldown timer
	can_roll = false
	$RollCooldown.start()


func _on_RollCooldown_timeout():
	can_roll = true
