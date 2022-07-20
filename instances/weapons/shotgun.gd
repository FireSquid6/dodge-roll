extends Weapon
class_name WeaponShotgun


var shots = 8


func create_projectile(projectile_position, projectile_angle):
	for i in range(shots):
		spawn_bullet(self, projectile, projectile_position, projectile_angle)
