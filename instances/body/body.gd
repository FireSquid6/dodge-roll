extends RigidBody2D
class_name DeadBody


func fire(starting_pos: Vector2, texture: Texture):
	# play animation
	$AnimationPlayer.play("fade_out")
	
	# set texture
	$Details.texture = texture
	
	# move
	position = starting_pos
	
	# apply the impulse
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var offset = Vector2(rng.randi_range(-32, 32), rng.randi_range(-32, 32))
	var strength = rng.randi_range(1500, 3000)
	var dir = Vector2(1, 0).rotated(rng.randi_range(0, TAU))
	
	apply_impulse(offset, dir * strength)
