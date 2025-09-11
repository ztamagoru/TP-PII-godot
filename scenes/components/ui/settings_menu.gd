extends Control

@onready var resolutions_option_button	= $MarginContainer/VBoxContainer/TabContainer/Video/MarginContainer/HBoxContainer/VideoSettings/ResolutionOptionButton
@onready var fullscreen_toggle			= $MarginContainer/VBoxContainer/TabContainer/Video/MarginContainer/HBoxContainer/VideoSettings/FullscreenCheckBox

@onready var master_label	= $MarginContainer/VBoxContainer/TabContainer/Audio/MarginContainer/VBoxContainer/HBoxContainer/CurrentMasterVolume
@onready var master_slider	= $MarginContainer/VBoxContainer/TabContainer/Audio/MarginContainer/VBoxContainer/HBoxContainer/AudioSettings/MasterVolumeSlider
@onready var music_label	= $MarginContainer/VBoxContainer/TabContainer/Audio/MarginContainer/VBoxContainer/HBoxContainer2/CurrentMusicVolume
@onready var music_slider	= $MarginContainer/VBoxContainer/TabContainer/Audio/MarginContainer/VBoxContainer/HBoxContainer2/AudioSettings/MusicVolumeSlider
@onready var sfx_label		= $MarginContainer/VBoxContainer/TabContainer/Audio/MarginContainer/VBoxContainer/HBoxContainer3/CurrentSFXVolume
@onready var sfx_slider		= $MarginContainer/VBoxContainer/TabContainer/Audio/MarginContainer/VBoxContainer/HBoxContainer3/AudioSettings/SFXVolumeSlider

func _ready():
	add_resolution()
	load_video_settings()
	load_audio_settings()

#region video settings

func add_resolution():
	for r in GUI.resolutions:
		resolutions_option_button.add_item(r)
	
	update_button_values()

func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolutions_index = GUI.resolutions.keys().find(window_size_string)
	
	if resolutions_index != null:
		resolutions_option_button.selected = resolutions_index

func load_video_settings():
	fullscreen_toggle.button_pressed = SaveManager.settings.fullscreen
	
	if SaveManager.settings.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	var saved_res = SaveManager.settings.resolution
	
	if not GUI.resolutions.has(saved_res):
		SaveManager.settings.resolution = get_closest_resolution(saved_res)
	
	DisplayServer.window_set_size(GUI.resolutions[SaveManager.settings.resolution])
	GUI.center_window()

func get_closest_resolution(target_str: String):
	var target = Vector2i(1152, 648) #default
	
	if target_str.find("x") != -1:
		var parts = target_str.split("x")
		if parts.size() == 2 and parts[0].is_valid_int() and parts[1].is_valid_int():
			target = Vector2i(int(parts[0]), int(parts[1]))
	
	var closest_key = ""
	var closest_dist = INF
	
	for key in GUI.resolutions.keys():
		var res = GUI.resolutions[key]
		var dist = target.distance_to(res)
		
		if dist < closest_dist:
			closest_dist = dist
			closest_key = key
	
	print("corrected wrong resolution from: ", target_str, " to ", closest_key)
	
	return closest_key

func _on_resolution_option_button_item_selected(index):
	var key = resolutions_option_button.get_item_text(index)
	DisplayServer.window_set_size(GUI.resolutions[key])
	SaveManager.settings.resolution = key
	
	GUI.center_window()
	SaveManager.save_settings()

func _on_fullscreen_check_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	SaveManager.settings.fullscreen = toggled_on
	SaveManager.save_settings()

func _on_close_settings_button_pressed() -> void:
	visible = !visible
 
#endregion

#region audio settings

func load_audio_settings():
	AudioServer.set_bus_volume_db(0, SaveManager.settings.volume_master)
	master_label.text = str(int(SaveManager.settings.volume_master))
	master_slider.value = SaveManager.settings.volume_master
	
	AudioServer.set_bus_volume_db(1, SaveManager.settings.volume_music)
	music_label.text = str(int(SaveManager.settings.volume_music))
	music_slider.value = SaveManager.settings.volume_music
	
	AudioServer.set_bus_volume_db(2, SaveManager.settings.volume_sfx)
	sfx_label.text = str(int(SaveManager.settings.volume_sfx))
	sfx_slider.value = SaveManager.settings.volume_sfx

func _on_master_volume_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(0, value)
	master_label.text = str(int(value))
	
	SaveManager.settings.volume_master = value
	SaveManager.save_settings()

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)
	music_label.text = str(int(value))
	
	SaveManager.settings.volume_music = value
	SaveManager.save_settings()

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)
	sfx_label.text = str(int(value))
	
	SaveManager.settings.volume_sfx = value
	SaveManager.save_settings()

#endregion
