extends Control

@export_file("*.tscn") var tutorial

func _ready():
	Globales.main_menu = self

func new_game_pressed():
	get_tree().change_scene_to_file(tutorial)

func continue_game_pressed():
	pass

func settings_open():
	var settings_menu = get_node("/root/GUI/SettingsMenu")
	settings_menu.visible = !settings_menu.visible
	
	if settings_menu.visible:
		#print("se debería haber abierto el menú de ajustes")
		settings_menu.update_button_values()

func quit_pressed():
	get_tree().quit()
