extends CanvasLayer

var gui_components = [
	"res://scenes/components/ui/pause_menu.tscn"
	, "res://scenes/components/ui/settings_menu.tscn"
	, "res://scenes/components/ui/confirm_quit.tscn"
]

var resolutions = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1600x900": Vector2i(1600,900),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1152x648": Vector2i(1152,648)
}

var vsync_modes = {
	"Desactivado": DisplayServer.VSYNC_DISABLED,
	"Activado": DisplayServer.VSYNC_ENABLED,
	"Adaptativo": DisplayServer.VSYNC_ADAPTIVE,
	"Mailbox": DisplayServer.VSYNC_MAILBOX
}

func _ready():
	for i in gui_components:
		var new_scene = load(i).instantiate()
		add_child(new_scene)
		new_scene.hide()

var hide_in_scenes : Array[String] = [ "MainMenu", "LevelSelect" ]

func _input(_event):
	if Input.is_action_just_pressed("toggle_pause"):
	
		if hide_in_scenes.has(get_tree().current_scene.name):
			return
		
		var pause_menu = get_node("/root/GUI/PauseMenu")
		
		pause_menu.visible = !pause_menu.visible
		pause_menu.toggle_level_pause()

func center_window():
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2) 
