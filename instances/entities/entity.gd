extends KinematicBody2D
class_name Entity


var health := 100
export var max_health := 100


func _init():
	health = max_health


func deal_damage(dmg):
	health -= dmg
