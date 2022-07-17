extends Navigation2D
class_name GameWorld


onready var walls: TileMap = get_node("Walls")
onready var inverse_walls: TileMap = get_node("InverseWalls")
onready var enemy_barriers: TileMap = get_node("EnemyBarriers")


func _ready():
	Global.world = self
	enemy_barriers.visible = false
	
	# SETUP NAVIGATION
	# get used rect of walls
	var used_rect: Rect2 = walls.get_used_rect()
	var top_cell: Vector2 = used_rect.position
	var bottom_cell: Vector2 = used_rect.end
	
	var empty_cell = walls.get_cell(-2, -8)
	
	# iterate through the used cells of the tilemap
	var cursor = top_cell
	while cursor.y < bottom_cell.y:
		while cursor.x < bottom_cell.x:
			# if the the current cell is empty
			var cell = walls.get_cellv(cursor)
			if cell == walls.INVALID_CELL:
				inverse_walls.set_cellv(cursor, 0)
			
			cursor.x += 1
		cursor.x = top_cell.x
		cursor.y += 1
	
	Global.setup_camera()


func get_path_to_player(start_pos):
	return get_simple_path(start_pos, Global.player.position)
