extends Control


func _ready():
	$AnimationPlayer.play("FadeOut")


# start the game
func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/levels/level_0.tscn")
