extends Projectile


var projectile_scene = preload("res://instances/weapons/shotgun/shotgun_projectile.tscn")
export var shots = 8


func fire(new_position, angle, new_mask):
	# fire the projectiles
	for i in range(shots):
		var projectile = projectile_scene.instance()
		Global.projectile_container.add_child(projectile)
		projectile.fire(new_position, angle, new_mask)
	
	# remove self
	queue_free()
	
