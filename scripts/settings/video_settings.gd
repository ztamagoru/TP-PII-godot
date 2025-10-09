extends VBoxContainer

@onready var resolutions_option_button	= $MarginContainer/HBoxContainer/VideoSettings/ResolutionOptionButton
@onready var vsync_option_button		= $MarginContainer/HBoxContainer/VideoSettings/VsyncOptionButton
@onready var fullscreen_toggle			= $MarginContainer/HBoxContainer/VideoSettings/FullscreenCheckBox

func _ready():
	add_resolution()
	add_vsync()
	load_video_settings()

func add_resolution():
	for r in GUI.resolutions:
		resolutions_option_button.add_item(r)
	
	update_resolution_button_values()

func update_resolution_button_values():
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
	load_video_settings()

func add_vsync():
	for r in GUI.vsync_modes:
		vsync_option_button.add_item(r)
	
	update_vsync_button_values()

func update_vsync_button_values():
	var current_vsync = SaveManager.settings.vsync
	
	var saved_mode = SaveManager.settings.vsync
	for i in vsync_option_button.get_item_count():
		var name = vsync_option_button.get_item_text(i)
		if GUI.vsync_modes[name] == saved_mode:
			vsync_option_button.selected = i
			break

func _on_vsync_option_button_item_selected(index):
	var key = vsync_option_button.get_item_text(index)
	DisplayServer.window_set_vsync_mode(GUI.vsync_modes[key])
	
	SaveManager.settings.vsync = GUI.vsync_modes[key]
	SaveManager.save_settings()
