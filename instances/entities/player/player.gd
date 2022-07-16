extends Entity
class_name Player


onready var state_machine: StateMachine = get_node("StateMachine")
onready var weapon_timer: Timer = get_node("WeaponTimer")
onready var hands: Polygon2D = get_node("Hands")

var velocity: Vector2 = Vector2.ZERO
export(Array, PackedScene) var weapons = [WeaponRevolver.new()]
export(int) var selected_weapon = 0


func _ready():
	Global.player = self
	weapons[selected_weapon].equip(weapon_timer)


func _physics_process(delta):
	# run through states
	state_machine.process_states(delta)
	
	# move and slide
	velocity = move_and_slide(velocity)


func update_weapon():
	var weapon: Weapon = weapons[selected_weapon]
	weapon.update(hands.global_position, hands.global_rotation)
