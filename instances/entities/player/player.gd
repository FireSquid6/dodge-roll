extends Entity
class_name Player


onready var state_machine: StateMachine = get_node("StateMachine")
onready var weapon_timer: Timer = get_node("WeaponTimer")
onready var hands: Polygon2D = get_node("Hands")
onready var face: AnimatedSprite = get_node("Sprite/Face")

var velocity: Vector2 = Vector2.ZERO
export(Array, PackedScene) var weapons = [WeaponRevolver.new(), WeaponSMG.new(), WeaponRifle.new()]
export(int) var selected_weapon = 0

export(int) var roll_heat = 0
export(int) var kill_heal = 50
export(int) var roll_cost = 50
export(int) var max_roll_heat = 150
export(int) var roll_heat_drain = 5

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	Global.player = self
	
	reroll_weapon()


func _process(delta):
	# set the correct face of the dice
	if !face.playing:
		face.frame = selected_weapon
	
	# manage roll heat
	roll_heat -= roll_heat_drain * delta
	roll_heat = clamp(roll_heat, 0, max_roll_heat)


func _physics_process(delta):
	# run through states
	state_machine.process_states(delta)
	
	# move and slide
	velocity = move_and_slide(velocity)


func update_weapon():
	var weapon: Weapon = weapons[selected_weapon]
	weapon.update(hands.global_position, hands.global_rotation)


func die():
	visible = false
	emit_signal("die")


func set_invincible(time):
	$InvincibilityTimer.wait_time = time
	$InvincibilityTimer.start()
	
	invincible = true


func _on_InvincibilityTimer_timeout():
	invincible = false


func _on_Player_damage_taken(dmg):
	print("I took damage :(")


func reroll_weapon():
	# get the index of the selected weapon
	selected_weapon = rng.randi_range(0, len(weapons) - 1)
	weapons[selected_weapon].equip(weapon_timer)
	
	# set the frame
	face.frame = selected_weapon


func enemy_killed(enemy):
	roll_heat -= kill_heal
