extends Control

onready var MenuSelect = $MenuSelectSound
onready var PauseSound = $PauseSound
onready var UnpauseSound = $UnpauseSound
onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
#onready var deathsLabel = $PlayerStatTrackers/VBoxContainer/Deaths
#onready var restartsLabel = $PlayerStatTrackers/VBoxContainer/Restarts
#onready	var timeLabel = $PlayerStatTrackers/VBoxContainer/Time
#onready var playerStatTrackers = $PlayerStatTrackers

var paused: = false setget set_paused

#func _ready():
	#deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
	#restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
	
#func _process(_delta):
	#timeLabel.text = "Time: " + PlayerStats.str_elapsed
#	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		PauseSound.play()
		scene_tree.set_input_as_handled()
		
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	#timeLabel.text = "Time: " + PlayerStats.str_elapsed
	#deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
	#restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
	pause_overlay.visible = value
#	playerStatTrackers.visible = value
	

	


func _on_ContinueButton_pressed():
	MenuSelect.play()
	UnpauseSound.play()
	set_paused(false)



func _on_RestartButton_pressed():
	PlayerStats.restarts += 1
	PlayerStats.reset_boss_health()
	MenuSelect.play()
	PlayerStats.reset_player_health()
	scene_tree.reload_current_scene()
	set_paused(false)


func _on_QuitButton_pressed():
	PlayerStats.main_menu()
	#TitleSongPlayer.stop()
	MenuSelect.play()
	set_paused(false)
	get_tree().change_scene("res://Menu/StartMenu.tscn")
	#MenuSelect.play()
	#scene_tree.quit()
