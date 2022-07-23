extends Area2D


signal pressed()
onready var animation_player = get_node("AnimationPlayer")
onready var lever_button = get_node("LeverButton")
var player_in_range = false


func _process(delta):
	lever_button.modulate = Color.white
	if player_in_range:
		lever_button.modulate = Color(1, 1, 0.5)
		if Input.is_action_just_pressed("interact"):
			press()


func press():
	# play animation
	animation_player.play("press")
	
	# emit the signal
	emit_signal("pressed")


func _on_Lever_body_entered(body):
	if body as Player:
		player_in_range = true


func _on_Lever_body_exited(body):
	if body as Player:
		player_in_range = false
