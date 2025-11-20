extends Control

@export_category("Levels")
@export_file("*.tscn") var level_selector
@export_file("*.tscn") var tutorial

@export_category("Buttons")
@export var continue_button : Button 

func _ready():
	Globales.main_menu = self
	
	continue_button.disabled = not SaveManager.game_exists()

func new_game_pressed():
	SaveManager.new_game()
	Globales.clear_data()
	
	get_tree().change_scene_to_file(tutorial)

func continue_game_pressed():
	Globales.load_game()
	
	get_tree().change_scene_to_file(level_selector)

func settings_open():
	var settings_menu = get_node("/root/GUI/SettingsMenu")
	settings_menu.visible = !settings_menu.visible
	
	if settings_menu.visible:
		#print("se debería haber abierto el menú de ajustes")
		settings_menu.VideoSettings.update_resolution_button_values()

func quit_pressed():
	get_tree().quit()
