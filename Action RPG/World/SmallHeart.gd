extends Area2D

onready var HeartPickupSound = $HeartPickupSound
onready var HeartSprite = $Sprite
onready var StartBlink = $Startblink
onready var animationPlayer = $AnimationPlayer

#3func _on_SmallHeart_body_entered(body):
	#PlayerStats.health += 1
	#queue_free()


func _on_SmallHeart_area_entered(_area):
	
	if PlayerStats.health < PlayerStats.max_health:
		PlayerStats.hearts += 1
		HeartPickupSound.play()
		PlayerStats.add_health(1)
		HeartSprite.scale.x = 0.5
		HeartSprite.scale.y = 0.5
	else:
		pass


func _on_HeartPickupSound_finished():
	queue_free()


func _on_Timer_timeout():
	StartBlink.start()
	animationPlayer.play("BlinkAnimation")


func _on_Startblink_timeout():
	queue_free()
