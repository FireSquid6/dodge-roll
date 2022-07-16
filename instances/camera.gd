extends Camera2D
class_name TraumaCamera2D


export var decay = 0.8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
export (NodePath) var target  # Assign the node this camera will follow.

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].


func _ready():
	randomize()
	Global.camera = self


# a bad icky gross workaround for my terrible code
func setup_self():
	var rect: Rect2 = Global.world.walls.get_used_rect()
	var size: Vector2 = Global.world.walls.cell_size
	
	limit_left = rect.position.x * size.x
	limit_right = rect.end.x * size.x
	limit_top = rect.position.y * size.y
	limit_bottom = rect.end.y * size.y


func _process(delta):
	# move based on mouse offset
	var mouse_offset = (get_viewport().get_mouse_position() - get_viewport().size / 2)
	position = lerp(Vector2(), mouse_offset.normalized() * 500, mouse_offset.length() / 1000)
	
	# screenshake
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()


func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
