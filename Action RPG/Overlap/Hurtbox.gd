extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible
var roll = false setget set_roll

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

signal invincibility_started
signal invincibility_ended

signal roll_started
signal roll_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func set_roll(value):
	invincible = value
	if invincible == true:
		emit_signal("roll_started")
	else:
		emit_signal("roll_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	
func stop_invincibility():
	self.invincible = false
	timer.stop()
	
func start_roll(duration):
	self.roll = true
	timer.start(duration)

func _create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
	
func ten_damage():
	pass

func _on_Timer_timeout():
	self.invincible = false
	self.roll = false

func _on_Hurtbox_invincibility_started():
	collisionShape.set_deferred("disabled", true)
	
func _on_Hurtbox_invincibility_ended():
	collisionShape.disabled = false
	
	
func _on_Hurtbox_roll_started():
	collisionShape.set_deferred("disabled", true)
	
func _on_Hurtbox_roll_ended():
	collisionShape.disabled = false
