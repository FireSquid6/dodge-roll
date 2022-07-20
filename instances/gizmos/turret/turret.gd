extends Node2D


var weapon = preload("res://resources/weapons/turret.tres").get_weapon()


func _ready():
	weapon.equip()


func _process(delta):
	weapon.update(position, rotation + PI / 2)
