extends Panel


export var bus_name = ""
onready var bus := AudioServer.get_bus_index(bus_name)
onready var hslider: HSlider = get_node("HBoxContainer/HSlider")
onready var label: Label = get_node("HBoxContainer/Label")


func _ready():
	label.text = bus_name
	hslider.value = db2linear(AudioServer.get_bus_volume_db(bus))


# mute if pressed
func _on_CheckBox_toggled(button_pressed):
	AudioServer.set_bus_mute(bus, button_pressed)


# change volume
func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(bus, linear2db(value))
