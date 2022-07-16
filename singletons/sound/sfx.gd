extends AudioStreamPlayer
class_name SFX


func _ready():
	connect("finished", self, "finished")
	bus = "SFX"


func sfx_play(new_stream, new_volume):
	stream = new_stream
	volume_db = new_volume
	
	play()


func finished():
	queue_free()
