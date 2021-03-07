extends Control

onready var scene_tree: = get_tree()
onready var deathsLabel = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer/Deaths
#$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Deaths
onready var restartsLabel = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer/Restarts
#$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Restarts
onready	var timeLabel = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer/Time
#$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Time
onready var kills = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer/Kills
#$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/Kills
onready var hearts =$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HeartsPickedUp
onready var damageDone = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer/DamageDone
#$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/DamageDone
onready var damageTaken = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/HBoxContainer/VBoxContainer/DamageTaken
#$PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/DamageTaken
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
onready var title = $PauseOverlay/MarginContainer/VBoxContainer2/HBoxContainer/MarginContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/PlayerStatTrackers/VBoxContainer/CenterContainer/Label

func _ready():
	title.text = "Thanks for Playing"
	timeLabel.text = "Time: " + str(PlayerStats.elapsed)
	kills.text = "Kills: " + str(PlayerStats.kills) + "/37"
	deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
	restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
	damageDone.text = "Upgrades: " + str(PlayerStats.upgrades) + "/6"
	damageTaken.text = "FINAL GRADE: "
	var average = 0
	set_paused(true)
	
	if PlayerStats.timeMinutes > 10:
		timeGrade.text = "F"
		average += 0
	elif PlayerStats.timeMinutes >= 7:
		timeGrade.text = "D"
		average += 1
	elif PlayerStats.timeMinutes >= 6:
		timeGrade.text = "C"
		average += 2
	elif PlayerStats.timeMinutes >= 5:
		timeGrade.text = "B"
		average += 3
	elif PlayerStats.timeMinutes > 4:
		timeGrade.text = "A"
		average += 4
	elif PlayerStats.timeMinutes >= 2:
		timeGrade.text = "S"
		average += 5
	elif PlayerStats.timeMinutes < 2:
		timeGrade.text = "SPEED"
		average += 5
		
	if PlayerStats.kills < 5:
		killsGrade.text = "F"
		average += 0
	elif PlayerStats.kills <= 10:
		killsGrade.text = "D"
		average += 1
	elif PlayerStats.kills <= 15:
		killsGrade.text = "C"
		average += 2
	elif PlayerStats.kills <= 25:
		killsGrade.text = "B"
		average += 3
	elif PlayerStats.kills <= 34:
		killsGrade.text = "A"
		average += 4
	elif PlayerStats.kills < 37:
		killsGrade.text = "S"
		average += 5
	elif PlayerStats.kills >= 37:
		killsGrade.text = "KILLER"
		average += 5
	#32 Soft Max on kills
	#18 bats guarding upgrad + boss
		
	if PlayerStats.deaths >= 11:
		deathsGrade.text = "Try Harder"
		average += 0
	elif PlayerStats.deaths >= 10:
		deathsGrade.text = "F"
		average += 0
	elif PlayerStats.deaths >= 8:
		deathsGrade.text = "D"
		average += 1
	elif PlayerStats.deaths >= 6:
		deathsGrade.text = "C"
		average += 2
	elif PlayerStats.deaths >= 4:
		deathsGrade.text = "B"
		average += 3
	elif PlayerStats.deaths >= 2:
		deathsGrade.text = "A"
		average += 4
	elif PlayerStats.deaths < 2:
		deathsGrade.text = "S"
		average += 5
	
	if PlayerStats.restarts > 10:
		restartsGrade.text = "F"
		average += 0
	elif PlayerStats.restarts >= 8:
		restartsGrade.text = "D"
		average += 1
	elif PlayerStats.restarts >= 6:
		restartsGrade.text = "C"
		average += 2
	elif PlayerStats.restarts >= 4:
		restartsGrade.text = "B"
		average += 3
	elif PlayerStats.restarts >= 2:
		restartsGrade.text = "A"
		average += 4
	elif PlayerStats.restarts < 2:
		restartsGrade.text = "S"
		average += 5
		
	if PlayerStats.upgrades <= 1:
		upgradesGrade.text = "F"
		average += 0
	elif PlayerStats.upgrades <= 2:
		upgradesGrade.text = "D"
		average += 1
	elif PlayerStats.upgrades <= 3:
		upgradesGrade.text = "C"
		average += 2
	elif PlayerStats.upgrades <= 4:
		upgradesGrade.text = "B"
		average += 3
	elif PlayerStats.upgrades < 5:
		upgradesGrade.text = "A"
		average += 4
	elif PlayerStats.upgrades >= 6:
		upgradesGrade.text = "S"
		average += 5
		
	average = average/5
	
	if average == 0:
		finalGrade.text = "F"

	elif average <= 1:
		finalGrade.text = "D"

	elif average <= 2:
		finalGrade.text = "C"

	elif average <= 3:
		finalGrade.text = "B"

	elif average <= 4:
		finalGrade.text = "A"

	elif average <= 5:
		finalGrade.text = "S"

	
	#restartsGrade.text = "S"
	#upgradesGrade.text = "S"	
	#hearts.text = "Hearts: " + str(PlayerStats.hearts)
	#rolls.text = "Rolls: " + str(PlayerStats.rolls)
	#damageTaken.text = "Damage Taken: " + str(PlayerStats.damageTaken)
	#if PlayerStats.checkpoint == true:
		#checkpointButton.set_visible(true)

var paused: = true setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("pause"):
		set_paused(true)
		#if PlayerStats.checkpoint == true:
		#	checkpointButton.set_visible(true)
		#else:
		#	pass
		#rolls.text = "Rolls: " + str(PlayerStats.rolls)
		#damageTaken.text = "Damage Taken: " + str(PlayerStats.damageTaken)
		#deathsLabel.text = "Deaths: " + str(PlayerStats.deaths)
		#restartsLabel.text = "Restarts: " + str(PlayerStats.restarts)
		#timeLabel.text = "Time: " + PlayerStats.elapsed
		#kills.text = "Kills: " + str(PlayerStats.kills)
		#hearts.text = "Hearts: " + str(PlayerStats.hearts)
		#damageDone.text = "Damage Dealt: " + str(PlayerStats.damageDone)
		#if PlayerStats.health == 0:
		scene_tree.set_input_as_handled()
		#else:
		#	pass

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
	PlayerStats.kills = 0
	PlayerStats.upgrades = 0
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
