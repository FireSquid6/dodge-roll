extends Area2D


var active = false
var player_inside = false

onready var child_point: Position2D
onready var teleporter_center: Sprite = get_node("TeleporterCenter")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

const inactive_color = Color(0.25, 0.25, 0.25)
const ready_color = Color(0.7, 1, 1)
const hover_color = Color(1, 1, 0.5)


func _ready():
	teleporter_center.modulate = inactive_color
	
	# get child point
	for child in get_children():
		if child as Position2D:
			child_point = child
			active = true
			teleporter_center.modulate = ready_color
			


func _process(_delta):
	if active:
		teleporter_center.modulate = ready_color
		if player_inside:
			teleporter_center.modulate = hover_color
			if Input.is_action_just_pressed("interact"):
				teleport(Global.player, child_point.global_position)


func teleport(node: Node2D, new_position: Vector2) -> void:
	# move the node
	node.position = new_position
	
	# play the animation
	active = false
	animation_player.play("teleport")
	
	# play the sound
	Sound.play_sfx(preload("res://sounds/sfx/teleport.wav"))


# set variable if the player is inside the area
func _on_Teleporter_body_entered(body):
	if body as Player:
		player_inside = true

func _on_Teleporter_body_exited(body):
	if body as Player:
		player_inside = false


func _on_AnimationPlayer_animation_finished(anim_name):
	active = true
