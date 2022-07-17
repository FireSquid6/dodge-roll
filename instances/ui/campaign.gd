extends Control


onready var enemies_left = get_node("EnemiesLeft")


func _ready():
	visible = true
	if Global.mode != Global.MODES.CAMPAIGN:
		queue_free()


func _process(delta):
	# set enemies left
	enemies_left.text = "Enemies Left: " + str(Global.enemies_left)
