extends Area2D

@export var camara : Camera2D
@export var pared_de_seguridad : CollisionShape2D
@export var movimiento : Vector2

func _process(_delta):
	if overlaps_body(Globales.jugador):
			var tween = create_tween()
			tween.tween_property(camara, "position", camara.position + movimiento, 1)
			pared_de_seguridad.disabled = false
			monitoring = false
