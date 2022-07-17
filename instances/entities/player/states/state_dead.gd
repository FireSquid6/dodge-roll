extends PlayerState


func _enter(args :=[]):
	player.invincible = true
	player.hands.visible = false
	player.sprite.modulate = Color(0.3, 0.3, 0.3, 1)
	player.shield.visible = false
	player.hud.restart_label.visible = true
	player.health = 0
	player.roll_heat = 0
	player.set_collision_layer_bit(1, false)
