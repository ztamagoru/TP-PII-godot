extends Area2D

@onready var posicion_inicial: Vector2 = position
var distancia: float = 100
var velocidad: float = 200.0
var direccion: Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	position += direccion * velocidad * delta

	if position.distance_to(posicion_inicial) >= distancia:
		direccion = -direccion
