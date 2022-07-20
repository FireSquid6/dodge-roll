extends Control


onready var enemies_left = get_node("EnemiesLeft")
onready var time_left = get_node("TimeLeft")


func _ready():
	visible = true
	if Global.level.mode != Global.level.MODES.CAMPAIGN:
		queue_free()


func _process(delta):
	# set enemies left
	enemies_left.text = "Enemies Left: " + str(Global.level.enemies_left)
	
	# set the time
	if Global.level.level_time.time_left > 0:
		var seconds = str(int(Global.level.level_time.time_left) % 60)
		var minutes = str(floor(Global.level.level_time.time_left / 60))
		if len(seconds) < 2:
			seconds = "0" + seconds
		
		time_left.text = "Time Left: \n" + minutes + ":" + seconds
	else:
		time_left.text = "Out of time!"
