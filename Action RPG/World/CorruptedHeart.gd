extends Area2D

onready var HeartPickupSound = $HeartPickupSound
onready var HeartSprite = $Sprite
onready var StartBlink = $Startblink
onready var animationPlayer = $AnimationPlayer
var victoryMenu =  preload("res://Menu/VictoryMenu.tscn")

signal add_max_health(value)

#3func _on_SmallHeart_body_entered(body):
	#PlayerStats.health += 1
	#queue_free()


func _on_SmallHeart_area_entered(area):
	var ysort = get_parent()
	var world = ysort.get_parent()
	world.get_node("UI").add_child(victoryMenu.instance())
	queue_free()
		#PlayerStats.add_max_health(1)
	HeartPickupSound.play()
		#HeartSprite.scale.x = 0.5
		#HeartSprite.scale.y = 0.5


func _on_HeartPickupSound_finished():
	queue_free()
