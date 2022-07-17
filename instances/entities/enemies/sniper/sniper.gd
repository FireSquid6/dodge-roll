extends Enemy


func _init():
	reflex = 0
	sight = 1600


func _ready():
	max_health = 25
	health = max_health
