extends KinematicBody2D
class_name Entity


var max_health := 100.0
var health := 100.0
var invincible = false

onready var hitflash_material = preload("res://instances/entities/hitflash.tres")
var hitflash_timer: Timer
export var hitflash_time = 0.2

signal damage_taken(dmg)
signal die()

var damage_sfx = preload("res://sounds/sfx/damage.wav")
var die_sfx = preload("res://sounds/sfx/dead.wav")
var dead = false


func _ready():
	health = max_health
	
	hitflash_timer = Timer.new()
	add_child(hitflash_timer)
	
	hitflash_timer.one_shot = true
	hitflash_timer.wait_time = hitflash_time
	hitflash_timer.connect("timeout", self, "_on_HitflashTimer_timeout")


func deal_damage(dmg, break_invincibility = false):
	if !invincible or break_invincibility:
		# subtract health
		health -= dmg
		
		# play and hitflash
		Sound.play_sfx(damage_sfx)
		hitflash_timer.start()
		material = hitflash_material
		
		# emit signals
		emit_signal("damage_taken", dmg)
		
		# check if dead
		if health <= 0 and !dead:
			dead = true
			die()


func _on_HitflashTimer_timeout():
	material = null


func die():
	queue_free()
	Sound.play_sfx(die_sfx)
	emit_signal("die")
