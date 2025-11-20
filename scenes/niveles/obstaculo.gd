extends Area2D

@onready var posicion_inicial: Vector2 = position
var distancia: float = 100
var velocidad: float = 200.0
var direccion: Vector2 = Vector2.DOWN

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("jugador"):
		get_parent().respawn()

func _physics_process(delta: float) -> void:
	position += direccion * velocidad * delta

	if position.distance_to(posicion_inicial) >= distancia:
		direccion = -direccion
