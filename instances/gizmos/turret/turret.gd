extends Node2D


var weapon = WeaponTurret.new()


func _ready():
	weapon.equip($WeaponTimer)


func _process(delta):
	weapon.update(position, rotation + PI / 2)
