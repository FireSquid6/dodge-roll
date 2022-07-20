extends Weapon
class_name WeaponBurst


var shots = 3
var current_shots 
var burst_cooldown = 0.03

var burst_shot = true


func _post_equip():
	current_shots = shots


func create_projectile(projectile_position, projectile_angle):
	spawn_bullet(self, projectile, projectile_position, projectile_angle)
	
	burst_shot = false
	current_shots -= 1
	
	if current_shots > 0:
		burst_shot = true
		can_fire = true
		timer.stop()
		burst_timer.start()


func burst_timer_timeout():
	burst_shot = true
	current_shots = shots


func get_shoot() -> bool:
	var shoot = burst_shot
	match fire_mode:
		FIRE_MODES.AUTO:
			shoot = Input.is_action_pressed("shoot")
		FIRE_MODES.SEMI:
			shoot = Input.is_action_just_pressed("shoot")
		FIRE_MODES.AI:
			shoot = true
	
	return shoot
