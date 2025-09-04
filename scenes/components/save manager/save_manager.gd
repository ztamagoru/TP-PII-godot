extends Node

var settings : Dictionary = {}

var route_settings : String = "user://settings.save"

func _ready():
	load_settings()

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
		"fullscreen": true,
		"resolution": [1920, 1080],
		"language": "es",
		"vsync": true,
		"brightness": 1.0
	}
