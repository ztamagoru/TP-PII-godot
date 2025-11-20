extends Node

@export var jugador : CharacterBody2D

var estado_actual : Estado

func _ready():
	estado_actual = get_child(0)
	estado_actual.enter()

func _process(_delta):
	estado_actual._update(_delta)

func _physics_process(_delta):
	estado_actual._physics_update(_delta)

func ir_a_estado_siguiente(estado_siguiente : String):
	estado_actual.exit()
	estado_actual = get_node(estado_siguiente)
	estado_actual.enter()
