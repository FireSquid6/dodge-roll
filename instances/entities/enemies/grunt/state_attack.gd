extends EnemyState


export var move_spd = 600
var weapon: WeaponRevolver = WeaponRevolver.new()


func _init():
	weapon.target_layer = 1
	weapon.connect("mag_empty", self, "_on_weapon_mag_empty")


func _enter(args := []):
	weapon.in_mag = weapon.mag_size


func _game_logic(delta):
	# dash towards the player
	var dir = enemy.position.direction_to(Global.player.position)
	enemy.move_and_slide(dir * move_spd)
	enemy.look_at(Global.player.position)
	enemy.rotation -= PI / 2
	
	# shoot
	weapon.update(enemy.position, enemy.position.angle_to_point(Global.player.position))



func _on_Sightline_player_lost():
	machine.change_state("StateIdle")


func _on_weapon_mag_empty():
	machine.change_state("StateReload", [1, "StateAttack", []])
