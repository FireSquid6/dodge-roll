extends Weapon
class_name WeaponSMG


func _init():
	weapon_name = "SMG"
	fire_mode = FIRE_MODES.AUTO
	mag_size = 24
	cooldown = 0.05
	projectile = preload("res://instances/weapons/smg/smg_projectile.tscn")
