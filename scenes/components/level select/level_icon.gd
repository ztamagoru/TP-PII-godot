@tool

extends Control
class_name LevelIcon

@export var level_index : int = 1
@export var level_id : String
@export_file("*.tscn") var go_to_level : String

@export_category("Adjacent Levels")
@export var next_level_up : LevelIcon
@export var next_level_down : LevelIcon
@export var next_level_left : LevelIcon
@export var next_level_right : LevelIcon

func _ready():
	$Label.text = "level " + str(level_index)
	$AnimatedSprite2D.visible = not Globales.unlocked_levels.has(level_id)

func _process(delta : float):
	if Engine.is_editor_hint():
		$Label.text = "level " + str(level_index)
		$AnimatedSprite2D.visible = not Globales.unlocked_levels.has(level_id)
