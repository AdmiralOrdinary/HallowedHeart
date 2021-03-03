extends Control
#onready var MenuSelect = $MenuSelect
#onready var TitleSongPlayer = $TitleSongPlayer
#onready var menu
onready var options = self

var _settings := {resolution = Vector2(320, 180), fullscreen = false, vsync = false}

signal toggled(is_button_pressed)


func _ready():
	#TitleSongPlayer.play()
	#PlayerStats.main_menu()
	#var options = get_parent().add_child(Options)
	pass

func update_settings(settings: Dictionary) -> void:
	OS.window_fullscreen = settings.fullscreen
	get_tree().set_screen_stretch(
		SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, settings.resolution
	)
	OS.set_window_size(settings.resolution)
	OS.vsync_enabled = settings.vsync

func _on_StartGameButton_pressed():
	options.set_visible(false)
	#menu.set_visible(true)

func _on_ApplyButton_pressed():
	update_settings(_settings)
	
func _on_UIResolutionSelector_resolution_changed(new_resolution: Vector2) -> void:
	_settings.resolution = new_resolution


func _on_UIVSyncCheckbox_toggled(is_button_pressed: bool) -> void:
	_settings.vsync = is_button_pressed


func _on_FullscreenHBoxContainer_toggled(is_button_pressed):
	_settings.fullscreen = is_button_pressed
