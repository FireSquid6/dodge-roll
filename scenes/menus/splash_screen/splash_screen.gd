extends Control


func _ready():
	$AnimationPlayer.play("FadeOut")


# start the game
func _on_AnimationPlayer_animation_finished(anim_name):
	var level_0 = load("res://scenes/levels/level_0.tscn")
	get_tree().change_scene_to(level_0)
