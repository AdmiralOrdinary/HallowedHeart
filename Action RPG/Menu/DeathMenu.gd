extends Control

onready var scene_tree: = get_tree()
onready var deathsLabel = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Deaths
onready var restartsLabel = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Restarts
onready	var timeLabel = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Time
onready var kills = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Kills
onready var hearts =$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HeartsPickedUp
onready var damageDone = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/DamageDone
onready var damageTaken =$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/DamageTaken
onready var rolls = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Rolls
onready var checkpointButton = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer2/VBoxContainer/CheckpointButton
onready var MenuSelect = $MenuSelectSound

func _ready():
	deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
	restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
	timeLabel.text = "Time: " + PlayerStats.elapsed
	kills.text = "Kills: " + str(PlayerStats.kills)
	hearts.text = "Hearts: " + str(PlayerStats.hearts)
	damageDone.text = "Damage Dealt: " + str(PlayerStats.damageDone)
	rolls.text = "Rolls: " + str(PlayerStats.rolls)
	damageTaken.text = "Damage Taken: " + str(PlayerStats.damageTaken)

var paused: = true setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if PlayerStats.checkpoint == true:
			checkpointButton.set_visible(true)
		else:
			pass
		rolls.text = "Rolls: " + str(PlayerStats.rolls)
		damageTaken.text = "Damage Taken: " + str(PlayerStats.damageTaken)
		deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
		restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
		timeLabel.text = "Time: " + PlayerStats.elapsed
		kills.text = "Kills: " + str(PlayerStats.kills)
		hearts.text = "Hearts: " + str(PlayerStats.hearts)
		damageDone.text = "Damage Dealt: " + str(PlayerStats.damageDone)
		if PlayerStats.health == 0:
			scene_tree.set_input_as_handled()
		else:
			pass

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value

func _on_CheckpointButton_pressed():
	PlayerStats.restarts += 1
	PlayerStats.reset_boss_health()
	MenuSelect.play()
	PlayerStats.checkpoint()
	scene_tree.reload_current_scene()
	set_paused(false)

func _on_RestartButton_pressed():
	MenuSelect.play()
	PlayerStats.reset_player_health()
	PlayerStats.reset_boss_health()
	scene_tree.reload_current_scene()
	set_paused(false)
	queue_free()

func _on_QuitButton_pressed():
	PlayerStats.main_menu()
	#TitleSongPlayer.stop()
	MenuSelect.play()
	set_paused(false)
	get_tree().change_scene("res://Menu/StartMenu.tscn")
	#MenuSelect.play()
	#scene_tree.quit()
