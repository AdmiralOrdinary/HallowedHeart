extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(_body):
	player = null


func _on_World2PlayerDetectionZone_body_entered(body):
	get_tree().change_scene("res://World3.tscn")
	#self.monitoring = false
	pass
	
func _on_World1PlayerDetectionZone_body_entered(body):
	#self.monitoring = false
	pass

func _on_World2PlayerDetectionZone_body_exited(body):
	#self.monitoring = true
	pass

func _on_World1PlayerDetectionZone2_body_exited(body):
	#self.monitoring = true
	pass


func _on_World1PlayerDetectionZone2_body_entered(body):
	#self.monitoring = false
	pass
