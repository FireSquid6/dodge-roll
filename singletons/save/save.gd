extends Object
class_name Save


class AudioSettings:
	var volume
	var muted
	
	func _init(_muted: bool, _volume: float):
		volume = _volume
		muted = _muted


var audio_settings = {
	"Master" : AudioSettings.new(false, 0),
	"SFX" : AudioSettings.new(false, 0),
	"Music" : AudioSettings.new(false, 0)
}
var aim_assist = true


func _init():
	# setup audio settings
	for key in audio_settings.keys():
		var settings: AudioSettings = audio_settings[key]
		var bus = AudioServer.get_bus_index(key)
		
		AudioServer.set_bus_mute(bus, settings.muted)
		AudioServer.set_bus_volume_db(bus, settings.volume)
