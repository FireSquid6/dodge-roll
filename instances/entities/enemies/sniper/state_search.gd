extends EnemyState


var weapon: WeaponSniper = WeaponSniper.new()
onready var tracking_timer = get_node("TrackingTimer")
onready var weapon_timer = get_node("WeaponTimer")
onready var line = get_node("Line2D")


func _enter(args := []):
	if !enemy.sightline.is_connected("player_lost", self, "_on_Sightline_player_lost"):
		enemy.sightline.connect("player_lost", self, "_on_Sightline_player_lost")
	
	weapon.equip(weapon_timer)
	tracking_timer.start()
	
	line.visible = true


func _exit(args := []):
	line.visible = false


func _game_logic(delta):
	# move the line
	line.points[0] = enemy.position
	line.points[1] = Global.player.position
	
	# point towards the player
	enemy.look_at_player()


func _on_Sightline_player_lost():
	machine.change_state("StateIdle")


func _on_TrackingTimer_timeout():
	if machine.selected_state == self:
		# shoot
		weapon.update(enemy.position, enemy.position.angle_to_point(Global.player.position) - PI / 2)
		
		# reset tracking timer
		tracking_timer.start()
