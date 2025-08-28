extends CharacterBody2D

@export var impulso_salto : float = 800
@export var speed = 20000
@export var gravedad : float = 2200
@export var sprite : AnimatedSprite2D

@export var hud : Control

var vida : int
var max_vida : int = 500

func _ready():
	inicializar_jugador()
	#Globales.jugador = self
	#actualizar_hud()

func _physics_process(_delta):
	pass

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
