extends Entity
class_name Player


onready var state_machine: StateMachine = get_node("StateMachine")
var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta):
	state_machine.process_states(delta)
