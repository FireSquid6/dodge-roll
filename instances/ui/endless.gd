extends Control


onready var score = get_node("Score")
onready var time_bar = get_node("Panel/Multiplier/ProgressBar")


func _process(delta):
	score.text = "Score:\n" + str(Global.score)
	
	time_bar.value = Global.multiplier_timer.time_left
