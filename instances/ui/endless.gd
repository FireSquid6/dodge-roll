extends Control


onready var score = get_node("Score")
onready var time_bar = get_node("Panel/Multiplier/ProgressBar")
onready var multiplier = get_node("Panel/Multiplier/Multiplier")

func _process(delta):
	score.text = "Score:\n" + str(Global.level.score)
	
	time_bar.value = Global.level.multiplier_timer.time_left
	time_bar.max_value = Global.level.multiplier_timer.wait_time
	
	multiplier.text = "x" + str(Global.level.multiplier)
