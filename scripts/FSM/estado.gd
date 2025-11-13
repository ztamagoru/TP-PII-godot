extends Node
class_name Estado

var jugador : CharacterBody2D

func _ready():
	jugador = get_parent().jugador

func enter():
	pass
	
func _update(_delta):
	pass

func _physics_update(_delta):
	pass

func exit():
	pass
