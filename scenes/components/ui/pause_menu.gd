extends Control

func _on_reanudar_button_pressed() -> void:
	visible = !visible

func _on_settings_button_pressed() -> void:
	var settings_menu = get_node("/root/GUI/SettingsMenu")
	settings_menu.visible = !settings_menu.visible
	
	if settings_menu.visible:
		#print("se debería haber abierto el menú de ajustes")
		settings_menu.update_button_values()


func _on_quit_button_pressed() -> void:
	var confirm_quit = get_node("/root/GUI/ConfirmQuit")
	confirm_quit.visible = !confirm_quit.visible

func _process(delta: float) -> void:
	if visible:
		return
	
	var settings_menu = get_node("/root/GUI/SettingsMenu")
	var confirm_quit = get_node("/root/GUI/ConfirmQuit")
	
	if confirm_quit.visible:
		confirm_quit.visible = !confirm_quit.visible
	
	if settings_menu.visible and not is_instance_valid(Globales.main_menu):
		settings_menu.visible = !settings_menu.visible
