tool
extends Control
#onready var MenuSelect = $MenuSelect
#onready var TitleSongPlayer = $TitleSongPlayer
#onready var menu

signal toggled(is_button_pressed)

export var title := "" setget set_title

onready var label := $FullMargin/Layer1VBox/SecondMargin/Layer2HBox/MarginContainer/VBoxContainer/FullscreenHBoxContainer/Label

func _on_CheckBox_toggled(button_pressed: bool) -> void:
	emit_signal("toggled", button_pressed)
	pass # Replace with function body.
	
func set_title(value: String) -> void:
	title = value
	
	if not label:
		yield(self, "ready")
		
	label.text = title
