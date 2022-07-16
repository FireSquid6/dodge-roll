extends Weapon
class_name WeaponSniper


func _init():
	weapon_name = "Sniper Rifle"
	fire_mode = FIRE_MODES.AI
	target_layer = 1
	mag_size = 99999
	cooldown = 0
	projectile = preload("res://instances/weapons/sniper_weapon/sniper_projectile.tscn")
	sound = preload("res://sounds/sfx/gunshot_heavy.wav")
