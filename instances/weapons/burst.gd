extends Weapon
class_name WeaponBurst


var shots = 3
var current_shots 
var burst_cooldown = 0.15

var burst_shot = false


func _post_equip():
	current_shots = shots


func create_projectile(projectile_position, projectile_angle):
	spawn_bullet(self, projectile, projectile_position, projectile_angle)
	
	burst_shot = false
	current_shots -= 1
	
	if current_shots > 0:
		can_fire = true
		Global.get_tree().create_timer(burst_cooldown).connect("timeout", self, "burst_timer_timeout")
		timer.time_left += burst_cooldown
	else:
		can_fire = false


func burst_timer_timeout():
	burst_shot = true


func get_shoot() -> bool:
	var shoot = false
	match fire_mode:
		FIRE_MODES.AUTO:
			shoot = Input.is_action_pressed("shoot")
		FIRE_MODES.SEMI:
			shoot = Input.is_action_just_pressed("shoot")
		FIRE_MODES.AI:
			shoot = true
	
	if burst_shot:
		shoot = true
	
	return shoot


func _on_Timer_timeout():
	current_shots = shots
	can_fire = true
