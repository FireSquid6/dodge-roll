extends KinematicBody2D
class_name Entity


var health := 100
var invincible = false
export var max_health := 100

signal damage_taken(dmg)
signal die()


func _ready():
	health = max_health


func deal_damage(dmg):
	if !invincible:
		# subtract health
		health -= dmg
		
		# emit signals
		emit_signal("damage_taken", dmg)
		
		# check if dead
		if health <= 0:
			die()


func die():
	queue_free()
	emit_signal("die")
