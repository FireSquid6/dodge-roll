extends Node2D
class_name Summoner


export(Array, PackedScene) var potential_enemies = [
	preload("res://instances/entities/enemies/grunt/grunt.tscn"),
	preload("res://instances/entities/enemies/sniper/sniper.tscn"),
	preload("res://instances/entities/enemies/charger/charger.tscn"),
	]
	


func summon(pos):
	# move to the correct position
	position = pos
	
	# play wthe animation
	$AnimationPlayer.play("summon")


func _on_AnimationPlayer_animation_finished(anim_name):
	# create the new enemy
	potential_enemies.shuffle()
	
	var enemy: Enemy = potential_enemies[0].instance()
	enemy.position = position
	Global.enemy_container.add_child(enemy)
	
	
	# kill self
	queue_free()
