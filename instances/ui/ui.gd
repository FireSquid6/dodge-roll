extends CanvasLayer


func _process(delta):
	$PauseScreen.visible = get_tree().paused
