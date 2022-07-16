extends Projectile


var explosion_scene = preload("res://instances/weapons/explosion/explosion.tscn")


func process_collision(collision: KinematicCollision2D):
	# create the explosion
	var explosion = explosion_scene.instance()
	Global.projectile_container.add_child(explosion)
	explosion.position = position
	
	# kill self
	queue_free()
