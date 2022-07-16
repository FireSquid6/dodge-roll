extends Weapon
class_name WeaponRevolver


func _init():
	fire_mode = FIRE_MODES.SEMI
	mag_size = 99999
	cooldown = 0.2
	projectile = preload("res://instances/weapons/revolver/revolver_projectile.tscn")
