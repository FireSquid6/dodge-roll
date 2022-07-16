extends Weapon
class_name WeaponRPG


func _init():
	weapon_name = "Rocket Launcher"
	fire_mode = FIRE_MODES.SEMI
	mag_size = 1
	cooldown = 1
	projectile = preload("res://instances/weapons/rpg/rocket_projectile.tscn")
	sound = preload("res://sounds/sfx/gunshot_heavy.wav")
