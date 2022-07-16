extends Enemy


onready var base = get_node("Base")
onready var details = get_node("Details")


func _init():
	max_health = 25
