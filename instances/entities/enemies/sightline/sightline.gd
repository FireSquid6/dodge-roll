extends Area2D
class_name Sightline


export var sight_distance = 1028
export var reflex = 0.5
var player_in_sight = false
onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var raycast: RayShape2D = collision_shape.shape
onready var reflex_timer: Timer = get_node("Reflex")
onready var walline: Area2D = get_node("Walline")


signal player_spotted()
signal player_lost()


func _ready():
	# set the length and reflex properly
	raycast.length = sight_distance
	reflex_timer.wait_time = reflex


func _physics_process(delta):
	# angle towards the player
	global_rotation = global_position.angle_to_point(Global.player.global_position)
	
	# check if there are any walls in the way and the sightline can see the player
	if len(walline.get_overlapping_bodies()) == 0 and len(get_overlapping_bodies()) > 0:
		# if neccessary, start the timer
		if reflex_timer.is_stopped() and !player_in_sight:
			reflex_timer.start()
	# otherwise, stop the timer
	elif player_in_sight == true:
		player_in_sight = false
		emit_signal("player_lost")
		if !reflex_timer.is_stopped():
			reflex_timer.stop()


# SIGNALS
func _on_Reflex_timeout():
	player_in_sight = true
	emit_signal("player_spotted")
