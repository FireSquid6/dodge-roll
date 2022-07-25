extends Panel


export var bus_name = ""
onready var bus := AudioServer.get_bus_index(bus_name)
onready var hslider: HSlider = get_node("HBoxContainer/HSlider")


func _ready():
	hslider.value = db2linear(AudioServer.get_bus_volume_db(bus))


# mute if pressed
func _on_CheckBox_toggled(button_pressed):
	AudioServer.set_bus_mute(bus, button_pressed)
	Global.save.audio_settings[bus_name].muted = true


# change volume
func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(bus, linear2db(value))
	Global.save.audio_settings[bus_name].volume = linear2db(value)
