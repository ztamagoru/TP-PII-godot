extends Node2D

@export var paso_de_nivel_1 : Area2D
@export var pared_de_seguridad_1 : CollisionShape2D
@export var paso_de_nivel_2 : Area2D
@export var pared_de_seguridad_2 : CollisionShape2D
@export var camara : Camera2D

func _ready():
	Globales.current_level = self

func _process(_delta):
	pass
	#if paso_de_nivel_1:
		#if paso_de_nivel_1.overlaps_body(Globales.jugador):
			#var tween = create_tween()
			#tween.tween_property(camara, "position", camara.position + Vector2(1153,0), 1)
			#pared_de_seguridad_1.disabled = false
			#paso_de_nivel_1.monitoring = false
	#if paso_de_nivel_2:
		#if paso_de_nivel_2.overlaps_body(Globales.jugador):
			#var tween = create_tween()
			#tween.tween_property(camara, "position", camara.position + Vector2(1161,0), 1)
			#pared_de_seguridad_2.disabled = false
			#paso_de_nivel_2.monitoring = false
