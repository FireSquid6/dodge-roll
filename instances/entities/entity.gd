extends KinematicBody2D
class_name Entity


var health := 100
var invincible = false
export var max_health := 100

signal damage_taken(dmg)
signal die()

var damage_sfx = preload("res://sounds/sfx/damage.wav")
var die_sfx = preload("res://sounds/sfx/dead.wav")


func _ready():
	health = max_health


func deal_damage(dmg):
	if !invincible:
		# subtract health
		health -= dmg
		
		# play sound
		Sound.play_sfx(damage_sfx)
		
		# emit signals
		emit_signal("damage_taken", dmg)
		
		# check if dead
		if health <= 0:
			die()


func die():
	queue_free()
	Sound.play_sfx(die_sfx)
	emit_signal("die")
