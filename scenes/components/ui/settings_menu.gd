extends Control

@onready var VideoSettings : VBoxContainer = $MarginContainer/VBoxContainer/TabContainer/Video

func _on_close_settings_button_pressed() -> void:
	visible = !visible
