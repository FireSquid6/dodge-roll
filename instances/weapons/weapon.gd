extends Object
class_name Weapon


enum FIRE_MODES {
	AUTO,
	SEMI,
	AI
}

var fire_mode = FIRE_MODES.AUTO  # auto - trigger can be held down. semi - trigger has to be pressed each time
var damage = 10  # the damage the projectile does on collision
var accuracy = 0  # the amount of degrees the projectile can move off course
var speed = 4000  # the speed of the projectile
var mag_size = 6  # the amount of mags in the weapon
var cooldown = 0.2  # the amount of time that needs to pass between each shot
var projectile: PackedScene  # the projectile to shoot
var target_layer = 2  # the target layer of the weapon
var sound = preload("res://sounds/sfx/gunshot_light.wav")  # the sound the gun makes when fired
var weapon_name = "Gun" # the display name of the weapon
var screenshake = 0.1  # the shake of the weapon
var needs_ammo = true  # whether the weapon uses ammo or not

var can_fire = false  # whether the rifle can shoot or not post-cooldown
var in_mag = mag_size  # the ammo in the mag
var timer: SceneTreeTimer


signal mag_empty()


func equip():
	# set can fire
	can_fire = true
	
	# set in mag
	in_mag = mag_size
	
	_post_equip()


func _post_equip():
	pass


func update(projectile_position, projectile_angle):
	# check if this gun needs to fire
	if can_fire and in_mag > 0:
		var shoot = get_shoot()
		
		# if the gun can shoot
		if shoot:
			# reset cooldown and mag
			if needs_ammo:
				in_mag -= 1
			
			can_fire = false
			timer = Global.get_tree().create_timer(cooldown)
			timer.connect("timeout", self, "_on_Timer_timeout")
			
			# create the projectile
			create_projectile(projectile_position, projectile_angle)
			
			# play sound
			Sound.play_sfx(sound)
			
			# apply screenshake
			if fire_mode != FIRE_MODES.AI:
				Global.camera.add_trauma(screenshake)
			
			# emit signal
			if in_mag == 0:
				emit_signal("mag_empty")


func create_projectile(projectile_position, projectile_angle):
	# spawn the bullet
	spawn_bullet(self, projectile, projectile_position, projectile_angle)


func spawn_bullet(weapon: Object, projectile: PackedScene, projectile_position: Vector2, projectile_angle: float):
	# create the projectile
	var new_projectile: KinematicBody2D = projectile.instance()
	Global.projectile_container.add_child(new_projectile)
	if new_projectile.has_method("fire"):
		new_projectile.fire(weapon, projectile_position, projectile_angle, target_layer)


func get_shoot() -> bool:
	var shoot = false
	match fire_mode:
		FIRE_MODES.AUTO:
			shoot = Input.is_action_pressed("shoot")
		FIRE_MODES.SEMI:
			shoot = Input.is_action_just_pressed("shoot")
		FIRE_MODES.AI:
			shoot = true
	
	return shoot


func _on_Timer_timeout():
	can_fire = true
