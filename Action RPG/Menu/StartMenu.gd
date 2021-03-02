extends Control

onready var MenuSelect = $MenuSelect
onready var TitleSongPlayer = $TitleSongPlayer
onready var menu = $Menu
onready var options = get_parent().add_child(Options)

func _ready():
	TitleSongPlayer.play()
	PlayerStats.main_menu()
	var options = get_parent().add_child(Options)

func _on_StartGameButton_pressed():
	PlayerStats.main_menu()
	TitleSongPlayer.stop()
	MenuSelect.play()
	get_tree().change_scene("res://World/World.tscn")
	

func _on_QuitGameButton_pressed():
	TitleSongPlayer.stop()
	MenuSelect.play()
	get_tree().quit()


func _on_TitleSongPlayer_finished():
	TitleSongPlayer.play()


func _on_OptionsButton_pressed():
	options.visible = true
	menu.visible = false
