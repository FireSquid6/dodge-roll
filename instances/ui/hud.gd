extends Control
class_name HUD


onready var heatbar = get_node("Heatbar")
onready var healthbar = get_node("Panel/VBoxContainer/Healthbar/ProgressBar")
onready var health_label = get_node("Panel/VBoxContainer/Healthbar/Health")
onready var weapon_name = get_node("Panel/VBoxContainer/HBoxContainer/WeaponName")
onready var ammo_count = get_node("Panel/VBoxContainer/HBoxContainer/AmmoCount")
onready var restart_label: RichTextLabel = get_node("RestartLabel")
onready var campaign = get_node("Campaign")
onready var endless = get_node("Endless")


func _init():
	Global.hud = self
	Global.connect("mode_chosen", self, "mode_chosen")

func _ready():
	$Background.queue_free()
	visible = true
	restart_label.visible = false


func _process(delta):
	# set invisible if paused
	visible = !get_tree().paused
	
	# match all of the variables to the player's variables
	var player = Global.player
	
	heatbar.value = player.roll_heat
	heatbar.max_value = player.max_roll_heat
	
	healthbar.value = player.health
	healthbar.max_value = player.max_health
	var health_string = str(player.health)
	while len(health_string) < 2:
		health_string = "0" + health_string
	health_label.text = health_string[0] + health_string[1]
	
	weapon_name.text = player.weapons[player.selected_weapon].weapon_name
	ammo_count.text = str(player.weapons[player.selected_weapon].in_mag) + "/" + str(player.weapons[player.selected_weapon].mag_size)


func mode_chosen(mode):
	var control: Control
	match mode:
		Global.MODES.ENDLESS:
			control = campaign
		Global.MODES.CAMPAIGN:
			control = endless
	
	control.queue_free()
