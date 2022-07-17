extends Area2D


export var max_damage = 80
export var max_radius = 96
export var radius_growth = 700
export var falloff = 0.1  # damage = max_damage - ((distance / 4) * falloff)
var circle_radius = 1

onready var polygon = get_node("Sprite")


func _process(delta):
	# grow radius
	circle_radius += radius_growth * delta
	var scale = (circle_radius / max_radius) * 2
	polygon.scale = Vector2(scale, scale)
	
	if circle_radius >= max_radius:
		# play sound
		Sound.play_sfx(preload("res://sounds/sfx/explosion.wav"))
		
		# remove self
		queue_free()
		
		# explode
		Global.camera.add_trauma(0.2)
		for body in get_overlapping_bodies():
			if body as Entity:
				var distance = body.position.distance_to(position)
				var dmg = max_damage - (distance * 0.25 * falloff)
				body.deal_damage(dmg, true)
