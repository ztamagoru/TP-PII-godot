extends Area2D

@export var camera : Camera2D
@export var previous_section_collision : CollisionShape2D

@onready var shape : CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("jugador"):
		return
	
	var rect_shape = shape.shape as RectangleShape2D
	var extents = rect_shape.extents
	var pos = shape.global_position
	
	camera.limit_left = int(pos.x - extents.x)
	camera.limit_top = int(pos.y - extents.y)
	camera.limit_right = int(pos.x + extents.x)
	camera.limit_bottom = int(pos.y + extents.y)
	
	
