extends Weapon
class_name WeaponRevolver


func _init():
	weapon_name = "Revolver"
	fire_mode = FIRE_MODES.SEMI
	mag_size = 6
	cooldown = 0.2
	projectile = preload("res://instances/weapons/revolver/revolver_projectile.tscn")
