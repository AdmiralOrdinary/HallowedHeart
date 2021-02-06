extends Area2D

onready var HeartPickupSound = $HeartPickupSound
onready var HeartSprite = $Sprite
onready var StartBlink = $Startblink
onready var animationPlayer = $AnimationPlayer

#3func _on_SmallHeart_body_entered(body):
	#PlayerStats.health += 1
	#queue_free()


func _on_SmallHeart_area_entered(area):
		PlayerStats.add_damage(1)
		HeartPickupSound.play()
		HeartSprite.scale.x = 0.5
		HeartSprite.scale.y = 0.5


func _on_HeartPickupSound_finished():
	queue_free()
