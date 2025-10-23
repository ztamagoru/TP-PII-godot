extends Control
class_name LevelSelect

@onready var current_level : LevelIcon = $Level1
var previous_level : LevelIcon

func _ready():
	$PlayerIcon.global_position = current_level.global_position
	previous_level = current_level

func _input(event):
	if event.is_action_pressed("mover_izquierda") and current_level.next_level_left:
		current_level = current_level.next_level_left
	
	if event.is_action_pressed("mover_derecha") and current_level.next_level_right:
		current_level = current_level.next_level_right
	
	if event.is_action_pressed("mover_arriba") and current_level.next_level_up:
		current_level = current_level.next_level_up
	
	if event.is_action_pressed("mover_abajo") and current_level.next_level_down:
		current_level = current_level.next_level_down
	
	if event.is_action_pressed("ui_accept") and current_level.go_to_level:
		get_tree().change_scene_to_file(current_level.go_to_level)

func _process(delta: float) -> void:
	if previous_level != current_level:
		$PlayerIcon.global_position = current_level.global_position
	
	previous_level = current_level
	
