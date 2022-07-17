extends Entity
class_name Player


onready var state_machine: StateMachine = get_node("StateMachine")
onready var weapon_timer: Timer = get_node("WeaponTimer")
onready var hands: Sprite = get_node("Hands")
onready var face: AnimatedSprite = get_node("Sprite/Face")
onready var sprite: Sprite = get_node("Sprite")
onready var shield: Line2D = get_node("Sprite/Shield")
onready var heal_timer: Timer = get_node("HealTimer")
onready var hud: HUD = get_node("UI/HUD")

var velocity: Vector2 = Vector2.ZERO
export(Array, PackedScene) var weapons = [WeaponRevolver.new(), WeaponSMG.new(), WeaponRifle.new(), WeaponCarbine.new(), WeaponShotgun.new(), WeaponRPG.new()]
export(int) var selected_weapon = 0
var selected_weapon_choices = []

export(int) var roll_heat = 0
export(int) var kill_heal = 50
export(int) var roll_cost = 70
export(int) var max_roll_heat = 150
export(int) var roll_heat_drain = 5
export(int) var heal_rate = 25

var can_heal = false
var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	Global.player = self
	
	hud.mode_chosen(Global.mode)
	
	reroll_weapon()
	connect("damage_taken", self, "_on_Player_damage_taken")
	
	shield.visible = false
	
	# double check max health
	max_health = 50
	health = max_health


func _process(delta):
	# set the correct face of the dice
	if !face.playing:
		face.frame = selected_weapon
	
	# manage roll heat
	roll_heat -= roll_heat_drain * delta
	roll_heat = clamp(roll_heat, 0, max_roll_heat)
	
	# heal if able to
	if can_heal and (state_machine.selected_state.name != "StateDead"):
		health += heal_rate * delta
	
	health = clamp(health, 0, max_health)


func _physics_process(delta):
	# run through states
	state_machine.process_states(delta)
	
	# move and slide
	velocity = move_and_slide(velocity)


func update_weapon():
	var weapon: Weapon = weapons[selected_weapon]
	weapon.update(hands.spawn_position, hands.global_rotation)


func die():
	Sound.play_sfx(die_sfx)
	Global.camera.add_trauma(0.5)
	state_machine.change_state("StateDead")
	emit_signal("die")


func set_invincible(time):
	$InvincibilityTimer.wait_time = time
	$InvincibilityTimer.start()
	
	invincible = true


func _on_InvincibilityTimer_timeout():
	invincible = false


func _on_Player_damage_taken(dmg):
	# add screenshake
	Global.camera.add_trauma(0.2)
	
	# reset heal timer
	can_heal = false
	heal_timer.start()


func reroll_weapon():
	# if the bag is empty, regenerate it
	if len(selected_weapon_choices) == 0:
		for i in range(6):
			selected_weapon_choices.append(i)
	selected_weapon_choices.shuffle()
	
	# get the index of the selected weapon
	selected_weapon = selected_weapon_choices[0]
	selected_weapon_choices.remove(0)
	weapons[selected_weapon].equip(weapon_timer)
	
	# set the frame
	face.frame = selected_weapon


func enemy_killed(enemy):
	roll_heat -= kill_heal


func _on_HealTimer_timeout():
	can_heal = true
