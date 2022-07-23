extends Entity
class_name Enemy


export(NodePath) var animation_player_path = ""
onready var animation_player: AnimationPlayer = get_node(animation_player_path)
onready var state_machine = get_node("StateMachine")
onready var modulated: Node2D = get_node("Modulated")
onready var particles: CPUParticles2D = get_node("CPUParticles2D")

var reflex = 0.5
export var still_while_idle = false
var sight = 1024
onready var sightline: Sightline = get_node("Sightline")

const attack_color = Color("FFC0BF")
const idle_color = Color("21FA90")


func _enter_tree():
	Global.level.enemies_left += 1
	connect("die", self, "enemy_dead")


func _physics_process(delta):
	# move obstruction checkers
	var obstruction_shape: SegmentShape2D = SegmentShape2D.new()
	obstruction_shape.a = position
	obstruction_shape.b = Global.player.global_position
	sightline.obstruction_checker.get_node("CollisionShape2D").shape = obstruction_shape
	
	# run through states
	if state_machine:
		state_machine.process_states(delta)


func _process(delta):
	# manage colors
	modulated.modulate = Color(1, 1, 1, 1)
	if material == null:
		match state_machine.selected_state.name:
			"StateIdle":
				modulated.modulate = idle_color
			_:
				modulated.modulate = attack_color


func follow_path(path, amount):
	while amount > 0 and path.size() > 0:
		var distance = position.distance_to(path[0])
		
		# if the player can make it to the next point
		if distance <= amount:
			position = path[0]
			path.remove(0)
			
			amount -= distance
		# otherwise, travel as far as possible and exit
		else:
			rotation = position.angle_to(path[0])
			rotation += 90
			move_and_collide(position.direction_to(path[0]) * amount)
			
			break


func enemy_dead():
	# apply screenshake
	Global.camera.add_trauma(0.2)
	
	# create dead body
	var body: DeadBody = preload("res://instances/body/body.tscn").instance()
	Global.body_container.add_child(body)
	body.fire(position, get_node("Details").texture)
	
	# call player enemy killed signal
	Global.player.enemy_killed(self)
	Global.level._on_Global_enemy_killed()


func look_at_player():
	look_at(Global.player.position)
	rotation += PI / 2


func move_towards_player(move_spd):
	var dir = position.direction_to(Global.player.position)
	move_and_slide(dir * move_spd)


func _on_Enemy_damage_taken(dmg):
	particles.restart()
