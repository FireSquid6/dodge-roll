extends Weapon
class_name WeaponRifle


func _init():
	weapon_name = "Rifle"
	fire_mode = FIRE_MODES.SEMI
	mag_size = 4
	cooldown = 0.4
	projectile = preload("res://instances/weapons/rifle/rifle_projectile.tscn")
