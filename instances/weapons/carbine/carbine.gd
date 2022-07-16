extends Weapon
class_name WeaponCarbine


func _init():
	weapon_name = "Carbine"
	fire_mode = FIRE_MODES.AUTO
	mag_size = 16
	cooldown = 0.2
	projectile = preload("res://instances/weapons/carbine/carbine_projectile.tscn")
	sound = preload("res://sounds/sfx/gunshot_medium.wav")
	
