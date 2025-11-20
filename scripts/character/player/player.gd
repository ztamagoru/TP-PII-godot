extends CharacterBody2D

@export var impulso_salto : float = 1100
@export var speed = 20000
@export var gravedad : float = 2000
@export var sprite : AnimatedSprite2D

#@export var hud : Control

var vida : int
var max_vida : int = 500

var _can_dash : bool = true

func _ready():
	Globales.jugador = self
	inicializar_jugador()
	#Globales.jugador = self
	#actualizar_hud()

func _process(_delta):
	if velocity.x < 0:
		sprite.flip_h = true
	
	if velocity.x > 0:
		sprite.flip_h = false

func inicializar_jugador():
	vida = max_vida

func morir():
	queue_free()

func herir(cantidad : int):
	vida -= cantidad
	if vida <= 0:
		morir()

##func actualizar_hud():
	#hud.vida = vida
	#hud.max_vida = max_vida
	#hud.actualizar_valores()
