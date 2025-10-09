extends VBoxContainer

@export var action_items : Array[String]

@onready var video_settings_labels : VBoxContainer = $MarginContainer/HBoxContainer/VideoSettingsLabels
@onready var video_settings : VBoxContainer = $MarginContainer/HBoxContainer/VideoSettings

func _ready() -> void:
	create_action_remap_items()

func create_action_remap_items():
	for index in range(action_items.size()):
		var action = action_items[index]
		var label = Label.new()
		
		label.text = correct_input_name(action)
		label.custom_minimum_size.y = 55.0
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		video_settings_labels.add_child(label)
		
		var button = RemapButton.new()
		
		button.action = action
		button.custom_minimum_size.y = 55.0
		video_settings.add_child(button)

func correct_input_name(input_name : String):
	return input_name.replace("_", " ")
