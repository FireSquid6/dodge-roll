extends Control
class_name HUD


onready var heatbar = get_node("Heatbar")
onready var healthbar = get_node("Panel/VBoxContainer/Healthbar/ProgressBar")
onready var weapon_name = get_node("Panel/VBoxContainer/HBoxContainer/WeaponName")
onready var ammo_count = get_node("Panel/VBoxContainer/HBoxContainer/AmmoCount")


func _init():
	Global.hud = self

func _ready():
	$Background.queue_free()


func _process(delta):
	# match all of the variables to the player's variables
	var player: Player = Global.player
	
	heatbar.value = player.roll_heat
	heatbar.max_value = player.max_roll_heat
	
	healthbar.value = player.health
	healthbar.max_value = player.max_health
	
	weapon_name.text = player.weapons[player.selected_weapon].weapon_name
	ammo_count.text = str(player.weapons[player.selected_weapon].in_mag) + "/" + str(player.weapons[player.selected_weapon].mag_size)
