extends Node2D


var rect: Rect2
var difficulty
export var starting_difficulty = 2
export var player_safe_distance = 512
export(float) var difficulty_increase = 0.5
export var max_attempts = 10
export var max_difficulty = 8
export var wave_time = 8

onready var wave_timer = get_node("WaveTime")
onready var summoner_scene = preload("res://instances/summoner/summoner.tscn")
onready var summoners = get_node("Summoners")


func _ready():
	difficulty = starting_difficulty
	rect = Rect2($TopLeft.position, $BottomRight.position - $TopLeft.position)


func _on_WaveTime_timeout():
	# set the new wait time
	wave_timer.wait_time = wave_time
	
	# creat the rng
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# spawn enemies
	for i in range(floor(difficulty)):
		var attempts = 0
		while attempts < max_attempts:
			# get the random point
			var point = Vector2.ZERO
			point.x = rng.randi_range(rect.position.x, rect.end.x)
			point.y = rng.randi_range(rect.position.y, rect.end.y)
			
			# check if the point satisfies the conditions
			if Global.player.global_position.distance_to(point) > player_safe_distance:
				# create the summoner
				var summoner: Summoner = summoner_scene.instance()
				summoners.add_child(summoner)
				summoner.summon(point)
				
				break
			
			attempts += 1
			print("Spawning failed " + str(attempts) + " time(s) in a row!")
	
	# add to difficulty
	difficulty += difficulty_increase
