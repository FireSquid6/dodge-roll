extends Node2D


export var width = 64
export var length = 512
var anchor_node: Node2D = null
var snapping_enabled = false
var real_position = position


onready var snapped_pos: Node2D = get_node("Position2D")
onready var collision_shape: Node2D = get_node("Area2D/CollisionShape2D")
onready var real_pos_polygon: Polygon2D = get_node("Position2D/Polygon2D")
onready var area: Area2D = get_node("Area2D")


func _ready():
	# make mouse invisible
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	global_position = get_global_mouse_position()
	real_position = snapped_pos.global_position
	collision_shape.visible = false
	real_pos_polygon.visible = false
	
	if snapping_enabled and (anchor_node != null):
		# turn this on if I need to debug the cursor
		#real_pos_polygon.visible = true
		
		# set rotation
		collision_shape.visible = true
		collision_shape.rotation = anchor_node.position.angle_to_point(global_position)
		
		# snap to position
		snapped_pos.global_position = global_position
		for enemy in area.get_overlapping_bodies():
			enemy = enemy as Enemy
			if (enemy != null) and !(enemy as EnemyCharger):
				snapped_pos.global_position= enemy.global_position
				break
