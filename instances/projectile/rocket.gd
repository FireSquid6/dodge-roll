extends Projectile


onready var explosion = preload("res://instances/explosion/explosion.tscn")


func process_collision(collider):
	# create explosion
	var new_explosion = explosion.instance()
	Global.projectile_container.add_child(new_explosion)
	new_explosion.position = position
	
	# kill self
	queue_free()
