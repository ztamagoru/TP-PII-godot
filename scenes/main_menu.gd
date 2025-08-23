extends Control

@export var tutorial : PackedScene

func _ready():
	pass

func new_game_pressed():
	get_tree().change_scene_to_packed(tutorial)

func continue_game_pressed():
	pass

func settings_open():
	pass

func quit_pressed():
	get_tree().quit()
