extends Control


func _ready():
	$AnimationPlayer.play("FadeOut")


# start the game
func _on_AnimationPlayer_animation_finished(anim_name):
	var title_screen = load("res://scenes/menus/title_screen/title_screen.tscn")
	get_tree().change_scene_to(title_screen)
