extends Control
class_name TransitionManager


onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
var next_scene: PackedScene = null


func _ready():
	Global.transition = self
	visible = true
	animation_player.play("fade_in")
	

func _on_AnimationPlayer_animation_started(anim_name):
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	Global.level.score = 0
	Global.level.multiplier = 1
	Global.level.multiplier_timer.stop()
	
	if anim_name == "fade_out":
		if next_scene:
			get_tree().change_scene_to(next_scene)
		else:
			get_tree().reload_current_scene()


func _process(delta):
	if Input.is_action_just_pressed("restart"):
		reset_scene()


func goto_scene(scene: PackedScene):
	next_scene = scene
	animation_player.play("fade_out")


func reset_scene():
	next_scene = null
	animation_player.play("fade_out")
