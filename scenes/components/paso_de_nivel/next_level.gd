extends Area2D

@export_file("*.tscn") var next_level
@export var new_level_id : String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		get_tree().change_scene_to_file(next_level)
		
		if new_level_id:
			Globales.add_level(new_level_id)
