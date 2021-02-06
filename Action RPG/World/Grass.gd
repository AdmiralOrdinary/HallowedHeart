extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const SmallHeart = preload("res://World/SmallHeart.tscn")

func create_grass_effect():
		var grassEffect = GrassEffect.instance()
		var world = get_tree().current_scene
		get_parent().add_child(grassEffect)
		grassEffect.global_position = global_position
		
func create_smallheart():
	if PlayerStats.health != PlayerStats.max_health:
		if rand_range(0, 100) <= 50:
			var world = get_tree().current_scene
			var smallHeart = SmallHeart.instance()
			get_parent().add_child(smallHeart)
			smallHeart.set_global_position(self.get_global_position())
		else:
			pass
	else:
		pass
	


func _on_Hurtbox_area_entered(_area):
	create_smallheart()
	create_grass_effect()
	queue_free()
	
