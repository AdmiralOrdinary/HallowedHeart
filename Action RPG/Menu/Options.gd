extends Control

#onready var MenuSelect = $MenuSelect
#onready var TitleSongPlayer = $TitleSongPlayer
#onready var menu = get_parent().get_node(Menu)
onready var options = self

func _ready():
	#TitleSongPlayer.play()
	#PlayerStats.main_menu()
	#var options = get_parent().add_child(Options)
	pass
	
func _on_StartGameButton_pressed():
	options.visible = false
	#menu.visible = true
	

