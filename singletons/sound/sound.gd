extends Node


onready var music_player = get_node("Music")


func play_sfx(stream: AudioStream, volume = 0):
	var sfx: SFX = SFX.new()
	add_child(sfx)
	sfx.sfx_play(stream, volume)


func play_music(stream: AudioStream):
	music_player.stop()
	music_player.stream = stream
	music_player.play()
