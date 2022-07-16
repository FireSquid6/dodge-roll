extends EnemyState


var timer = Timer.new()
var next_state = ""
var next_state_args = []


func _ready():
	timer.one_shot = true
	timer.connect("timeout", self, "timer_ended")
	add_child(timer)


func _enter(args := [1, "", []]):
	next_state = args[1]
	next_state_args = args[2]
	timer.time_left = args[0]
	timer.start()


func timer_ended():
	if next_state != "":
		machine.change_state(next_state, next_state_args, [])
