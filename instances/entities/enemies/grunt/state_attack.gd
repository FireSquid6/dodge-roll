extends EnemyState


export var move_spd = 200
var weapon: GruntWeapon = GruntWeapon.new()


func _init():
	weapon.connect("mag_empty", self, "_on_weapon_mag_empty")


func _enter(args := []):
	if !enemy.sightline.is_connected("player_lost", self, "_on_Sightline_player_lost"):
		enemy.sightline.connect("player_lost", self, "_on_Sightline_player_lost")
	weapon.equip($WeaponTimer)


func _game_logic(delta):
	# dash towards the player
	enemy.move_towards_player(move_spd)
	enemy.look_at_player()
	
	# shoot
	weapon.update(enemy.position, enemy.position.angle_to_point(Global.player.position) - PI / 2)


func _on_Sightline_player_lost():
	machine.change_state("StateIdle")


func _on_weapon_mag_empty():
	machine.change_state("StateReload", [1.5, "StateAttack", []])
