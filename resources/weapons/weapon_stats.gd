extends Resource
class_name WeaponStats


enum PROJECTILE_TYPES {
	LIGHT,
	HEAVY,
	ROCKET
}

enum WEAPON_TYPES {
	REGULAR,
	SHOTGUN,
	BURST
}

# exports
export(WEAPON_TYPES) var weapon_type = WEAPON_TYPES.REGULAR
export(Weapon.FIRE_MODES) var fire_mode = Weapon.FIRE_MODES.SEMI
export(PROJECTILE_TYPES) var projectile_type = PROJECTILE_TYPES.LIGHT
export(String) var weapon_name = "Gun"
export(AudioStream) var sound = preload("res://sounds/sfx/gunshot_light.wav")
export(float, 0, 10000) var damage = 0
export(float, 0, 360) var accuracy = 0
export(float, 1000, 10000) var speed = 4000
export(float, 0, 10) var cooldown = 0.2
export(int, 1, 99) var mag_size = 8
export(float, 0, 1) var screenshake = 0.1
export(int, 1, 99) var projectiles = 1
export(float, 0, 10) var burst_cooldown = 0
export(bool) var uses_ammo = true


func get_weapon() -> Weapon:
	var weapon: Weapon
	
	# setup type specific stuff
	match weapon_type:
		WEAPON_TYPES.REGULAR:
			weapon = Weapon.new()
		WEAPON_TYPES.SHOTGUN:
			weapon = WeaponShotgun.new()
			weapon.shots = projectiles
		WEAPON_TYPES.BURST:
			weapon = WeaponBurst.new()
			weapon.shots = projectiles
			weapon.burst_cooldown = burst_cooldown
	
	# setup projectile info
	match projectile_type:
		PROJECTILE_TYPES.LIGHT:
			weapon.projectile = preload("res://instances/projectile/light_projectile.tscn")
		PROJECTILE_TYPES.HEAVY:
			weapon.projectile = preload("res://instances/projectile/heavy_projectile.tscn")
		PROJECTILE_TYPES.ROCKET:
			weapon.projectile = preload("res://instances/projectile/rocket.tscn")
	
	weapon.damage = damage
	weapon.speed = speed
	weapon.accuracy = accuracy
	
	# setup gun info
	weapon.weapon_name = weapon_name
	weapon.cooldown = cooldown
	weapon.mag_size = mag_size
	weapon.screenshake = screenshake
	weapon.sound = sound
	weapon.fire_mode = fire_mode
	weapon.needs_ammo = uses_ammo
	
	# return the weapon
	return weapon
