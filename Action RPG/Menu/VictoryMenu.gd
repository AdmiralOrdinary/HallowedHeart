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
onready var pause_overlay = $PauseOverlay
onready var timeGrade = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer2/TimeGrade
onready var killsGrade = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer2/KillsGrade
onready var deathsGrade = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer2/DeathsGrade
onready var restartsGrade = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer2/RestartsGrade
onready var upgradesGrade = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer2/UpgradesGrade
onready var finalGrade = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer2/FinalGrade

func _ready():
	timeLabel.text = "Time: " + PlayerStats.elapsed
	kills.text = "Kills: " + str(PlayerStats.kills)
	deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
	restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
	damageDone.text = "Damage Dealt: " + str(PlayerStats.damageDone)
	
	if PlayerStats.timeMinutes > 10:
		timeGrade.text = "F"
	elif PlayerStats.timeMinutes >= 8:
		timeGrade.text = "D"
	elif PlayerStats.timeMinutes >= 6:
		timeGrade.text = "C"
	elif PlayerStats.timeMinutes >= 4:
		timeGrade.text = "B"
	elif PlayerStats.timeMinutes >= 2:
		timeGrade.text = "A"
	elif PlayerStats.timeMinutes == 0:
		timeGrade.text = "S"
		
	if PlayerStats.kills < 5:
		killsGrade.text = "F"
	elif PlayerStats.kills <= 9:
		killsGrade.text = "D"
	elif PlayerStats.kills <= 12:
		killsGrade.text = "C"
	elif PlayerStats.kills <= 15:
		killsGrade.text = "B"
	elif PlayerStats.kills <= 18:
		killsGrade.text = "A"
	elif PlayerStats.kills >= 20:
		killsGrade.text = "S"
	#32 Soft Max on kills
	#18 bats guarding upgrad + boss
		
	killsGrade.text = "Kills: " + str(PlayerStats.kills)
	deathsGrade.text = "Deaths: " + str(PlayerStats.deaths)
	restartsGrade.text = "Restarts: " + str(PlayerStats.restarts)
	upgradesGrade.text = "Damage Dealt: " + str(PlayerStats.damageDone)		
	#hearts.text = "Hearts: " + str(PlayerStats.hearts)
	#rolls.text = "Rolls: " + str(PlayerStats.rolls)
	#damageTaken.text = "Damage Taken: " + str(PlayerStats.damageTaken)
	#if PlayerStats.checkpoint == true:
		#checkpointButton.set_visible(true)

var paused: = true setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(true)
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
	pause_overlay.visible = value

#func _on_CheckpointButton_pressed():
	
#	PlayerStats.restarts += 1
#	PlayerStats.reset_boss_health()
#	MenuSelect.play()
#	if PlayerStats.health == 0:
#		PlayerStats.checkpoint()
#		set_paused(false)
#		queue_free()
#	else:
#		PlayerStats.checkpoint()
#		set_paused(false)

	

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
