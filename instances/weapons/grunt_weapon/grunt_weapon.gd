extends Weapon
class_name GruntWeapon


func _init():
	fire_mode = FIRE_MODES.AI
	target_layer = 1
	mag_size = 6
	cooldown = 0.12
	projectile = preload("res://instances/weapons/grunt_weapon/grunt_projectile.tscn")
	sound = preload("res://sounds/sfx/gunshot_light.wav")
