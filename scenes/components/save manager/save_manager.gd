extends Node

var settings : Dictionary = {}
var game : Dictionary = {}
 
var route_settings : String = "user://settings.save"
var route_game : String = "user://game.save"

func _ready():
	load_settings()

func game_exists() -> bool :
	return FileAccess.file_exists(route_game)

func load_game(slot : int = 1):
	if not FileAccess.file_exists(route_game):
		set_default_game()
		save_game()
		return
	
	var file = FileAccess.open(route_game, FileAccess.READ)
	var text = file.get_as_text()
	
	var json = JSON.new()
	var error = json.parse(text)
	
	if error !=  OK:
		push_error("Error parsing game file, loading defaults")
		set_default_game()
		save_game()
		return
	
	game = json.data

func new_game():
	set_default_game()
	save_game()

func save_game():
	var file = FileAccess.open(route_game, FileAccess.WRITE)
	print("guardando el juego")
	file.store_line(JSON.stringify(game, "\t"))

func load_settings():
	if not FileAccess.file_exists(route_settings):
		set_default_settings()
		save_settings()
		return
	
	var file = FileAccess.open(route_settings, FileAccess.READ)
	
	var text = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(text)
	
	if error != OK:
		push_error("Error parsing settings file, loading defaults")
		set_default_settings()
		save_settings()
		return
	
	settings = json.data

func save_settings():
	var settings_file = FileAccess.open(route_settings, FileAccess.WRITE)
	print("guardando settings")
	settings_file.store_line(JSON.stringify(settings, "\t"))

func set_default_settings():
	settings = {
		"volume_master": 1.0,
		"volume_music": 1.0,
		"volume_sfx": 1.0,
		"fullscreen": false,
		"resolution": "1152x648",
		"language": "es",
		"vsync": 0.0,
		"brightness": 1.0
	}

func set_default_game():
	game = {
		"collected_items": [],
		"death_counter": 0,
		"unlocked_levels": []
	}
