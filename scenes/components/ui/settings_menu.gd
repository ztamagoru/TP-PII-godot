extends Control

@onready var resolutions_option_button = $MarginContainer/VBoxContainer/TabContainer/Video/MarginContainer/HBoxContainer/VideoSettings/ResolutionOptionButton

func _ready():
	add_resolution()

func add_resolution():
	for r in GUI.resolutions:
		resolutions_option_button.add_item(r)

func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolutions_index = GUI.resolutions.keys().find(window_size_string)
	
	resolutions_option_button.selected = resolutions_index

func _on_resolution_option_button_item_selected(index):
	var key = resolutions_option_button.get_item_text(index)
	DisplayServer.window_set_size(GUI.resolutions[key])
	
	GUI.center_window()

func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_close_settings_button_pressed() -> void:
	visible = !visible

#func _on_visibility_changed() -> void:
	#update_button_values()
