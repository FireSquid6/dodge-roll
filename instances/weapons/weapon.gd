extends Object
class_name Weapon


enum FIRE_MODES {
	AUTO,
	SEMI,
	AI
}

export(FIRE_MODES) var fire_mode = FIRE_MODES.AUTO  # auto - trigger can be held down. semi - trigger has to be pressed each time
export(int) var mag_size = 6  # the amount of mags in the weapon
export(float) var cooldown = 0.2  # the amount of time that needs to pass between each shot
export(PackedScene) var projectile  # the projectile to shoot
export(int) var target_layer = 2  # the target layer of the weapon
export(String) var weapon_name = "Gun"

var can_fire = false  # whether the rifle can shoot or not post-cooldown
var timer: Timer  # the timer for cooldown
var in_mag = mag_size  # the ammo in the mag


signal mag_empty()


func equip(new_timer: Timer):
	# setup the cooldown
	timer = new_timer
	timer.wait_time = cooldown
	timer.one_shot = true
	timer.connect("timeout", self, "_on_Timer_timeout")
	can_fire = true
	
	# set in mag
	in_mag = mag_size


func update(projectile_position, projectile_angle):
	# check if this gun needs to fire
	if can_fire and in_mag > 0:
		var shoot = false
		match fire_mode:
			FIRE_MODES.AUTO:
				shoot = Input.is_action_pressed("shoot")
			FIRE_MODES.SEMI:
				shoot = Input.is_action_just_pressed("shoot")
			FIRE_MODES.AI:
				shoot = true
		
		# if the gun can shoot
		if shoot:
			# create the projectile
			var new_projectile = projectile.instance()
			Global.projectile_container.add_child(new_projectile)
			new_projectile.fire(projectile_position, projectile_angle, target_layer)
			
			# reset cooldown and mag
			in_mag -= 1
			can_fire = false
			timer.start()
			
			# emit signal
			if in_mag == 0:
				emit_signal("mag_empty")
		


func _on_Timer_timeout():
	can_fire = true
	timer.start()
