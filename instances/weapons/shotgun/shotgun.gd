extends Weapon
class_name WeaponShotgun


func _init():
	weapon_name = "Shotgun"
	fire_mode = FIRE_MODES.SEMI
	mag_size = 2
	cooldown = 0.5
	projectile = preload("res://instances/weapons/shotgun/shotgun_shell.tscn")
	sound = preload("res://sounds/sfx/gunshot_heavy.wav")
