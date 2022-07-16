extends Area2D


export var max_damage = 50
export var max_radius = 96
export var radius_growth = 512
export var falloff = 0.3  # damage = max_damage - (distance * falloff)
var circle_radius = 1

onready var polygon = get_node("Polygon2D")


func _process(delta):
	# grow radius
	circle_radius += radius_growth * delta
	var scale = (circle_radius / max_radius) * 2
	polygon.scale = Vector2(scale, scale)
	
	if circle_radius >= max_radius:
		# remove self
		queue_free()
		
		# explode
		for body in get_overlapping_bodies():
			if body as Entity:
				var distance = body.position.distance_to(position)
				var dmg = max_damage - (distance * falloff)
				body.deal_damage(dmg)
