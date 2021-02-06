extends Control

onready var MenuSelect = $MenuSelect
onready var TitleSongPlayer = $TitleSongPlayer

func _ready():
	TitleSongPlayer.play()

func _on_StartGameButton_pressed():
	TitleSongPlayer.stop()
	MenuSelect.play()
	get_tree().change_scene("res://World/World.tscn")
	

func _on_QuitGameButton_pressed():
	TitleSongPlayer.stop()
	MenuSelect.play()
	get_tree().quit()


func _on_TitleSongPlayer_finished():
	TitleSongPlayer.play()
