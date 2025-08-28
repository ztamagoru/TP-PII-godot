extends Control

@export var main_menu : PackedScene

func _on_quit_desktop_button_pressed():
	get_tree().quit()

func _on_quit_menu_button_pressed():
	var pause_menu = get_node("/root/GUI/PauseMenu")
	
	visible = !visible
	pause_menu.visible = !pause_menu.visible
	get_tree().change_scene_to_packed(main_menu)

func _on_cancel_button_pressed():
	visible = !visible
