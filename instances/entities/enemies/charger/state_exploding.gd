extends EnemyState


var explosion_scene = preload("res://instances/weapons/explosion/explosion.tscn")


func _enter(args := []):
	# start the timer
	$Timer.start()
	
	# drop shield
	enemy.get_node("Shield").visible = false
	enemy.invincible = false


func _on_Timer_timeout():
	# create the explosion
	var explosion = explosion_scene.instance()
	Global.projectile_container.add_child(explosion)
	explosion.position = enemy.position
	
	
	# kill the enemy
	enemy.die()
