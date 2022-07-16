extends Weapon 
class_name WeaponTurret

func _init():
	fire_mode = FIRE_MODES.AI
	target_layer = 1
	mag_size = 99999
	cooldown = 0.15
	screenshake = 0
	projectile = preload("res://instances/weapons/turret_weapon/turret_projectile.tscn")
	sound = null
