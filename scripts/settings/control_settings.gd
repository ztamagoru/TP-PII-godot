extends VBoxContainer

@export var action_items : Array[String]

@onready var video_settings_labels : VBoxContainer = $MarginContainer/HBoxContainer/VideoSettingsLabels
@onready var video_settings : VBoxContainer = $MarginContainer/HBoxContainer/VideoSettings

func _ready() -> void:
	load_control_settings()
	create_action_remap_items()

func create_action_remap_items():
	for index in range(action_items.size()):
		var action = action_items[index]
		var button = RemapButton.new()
		
		button.action = action
		button.custom_minimum_size.y = 55.0
		video_settings.add_child(button)
		
		if button.input_not_existing():
			button.queue_free()
			continue
		else:
			button._get_ready()
		
		var label = Label.new()
		
		label.text = correct_input_name(action)
		label.custom_minimum_size.y = 55.0
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		video_settings_labels.add_child(label)
		
		button.connect("key_changed", Callable(self, "save_player_inputs"))

func correct_input_name(input_name : String):
	return input_name.replace("_", " ")

func load_control_settings():
	if not SaveManager.settings.has("inputs"):
		save_default_inputs()
		SaveManager.save_settings()
		return
	
	for action_name in SaveManager.settings["inputs"].keys():
		var keycode = int(SaveManager.settings["inputs"][action_name])
		
		var ev = InputEventKey.new()
		ev.physical_keycode = keycode
		ev.keycode = keycode
		ev.pressed = false
		
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, ev)

func save_player_inputs(action_name : String, key_physical : int):
	SaveManager.settings["inputs"][action_name] = key_physical
	SaveManager.save_settings()

func save_default_inputs():
	if not SaveManager.settings.has("inputs"):
		SaveManager.settings["inputs"] = {}
	
	for action in action_items:
		var events = InputMap.action_get_events(action)
		
		for ev in events:
			if ev is InputEventKey:
				SaveManager.settings["inputs"][action] = ev.keycode
