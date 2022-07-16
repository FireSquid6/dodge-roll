extends KinematicBody2D
class_name Projectile


export(float) var spd = 3200
export(int) var dmg = 10
export var accuracy = 0
var velocity = Vector2.ZERO
var mask = 2


func fire(new_position, angle, new_mask):
	# set position and velocity
	position = new_position
	var new_angle = angle + deg2rad(rand_range(-accuracy, accuracy))
	velocity = Vector2(spd, 0).rotated(new_angle - PI / 2)
	rotation = new_angle
	
	# set mask and layer
	mask = new_mask
	
	set_collision_mask_bit(mask, true)


func _physics_process(delta):
	# move
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# if there was a collision, process it
	if collision:
		process_collision(collision)


func process_collision(collision: KinematicCollision2D):
	# deal damage
	if collision.collider as Entity:
		collision.collider.deal_damage(dmg)
	
	# destroy the bullet
	queue_free()
