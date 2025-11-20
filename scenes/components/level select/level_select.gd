extends Control
class_name LevelSelect

@export_file("*.tscn") var main_menu
@onready var current_level : LevelIcon = $Level1
var previous_level : LevelIcon

func _ready():
	$PlayerIcon.global_position = current_level.global_position
	previous_level = current_level

func _input(event):
	if event.is_action_pressed("toggle_pause"):
		get_tree().change_scene_to_file(main_menu)
		return
	
	if event.is_action_pressed("mover_izquierda") and current_level.next_level_left:
		if Globales.unlocked_levels.has(current_level.next_level_left.level_id):
			current_level = current_level.next_level_left
	
	if event.is_action_pressed("mover_derecha") and current_level.next_level_right:
		if Globales.unlocked_levels.has(current_level.next_level_right.level_id):
			current_level = current_level.next_level_right
	
	if event.is_action_pressed("mover_arriba") and current_level.next_level_up:
		if Globales.unlocked_levels.has(current_level.next_level_up.level_id):
			current_level = current_level.next_level_up
	
	if event.is_action_pressed("mover_abajo") and current_level.next_level_down:
		if Globales.unlocked_levels.has(current_level.next_level_down.level_id):
			current_level = current_level.next_level_down
	
	if event.is_action_pressed("ui_accept") and current_level.go_to_level:
		get_tree().change_scene_to_file(current_level.go_to_level)

func _process(delta: float) -> void:
	if previous_level != current_level:
		$PlayerIcon.global_position = current_level.global_position
	
	previous_level = current_level
	
