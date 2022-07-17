extends Control


func _ready():
	# play music
	Sound.play_music(preload("res://sounds/music/music.mp3"))


func _on_Campaign_pressed():
	Global.set_mode(Global.MODES.CAMPAIGN)
	get_tree().change_scene("res://scenes/levels/level_0.tscn")
	get_tree().paused = false


func _on_Endless_pressed():
	Global.set_mode(Global.MODES.ENDLESS)
	get_tree().change_scene("res://scenes/endless/endless.tscn")
	get_tree().paused = false


func _on_MuteSFX_pressed():
	AudioServer.set_bus_mute(1, !AudioServer.is_bus_mute(1))


func _on_MuteMusic_pressed():
	AudioServer.set_bus_mute(2, !AudioServer.is_bus_mute(2))
