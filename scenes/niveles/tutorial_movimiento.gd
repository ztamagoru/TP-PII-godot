extends Node2D

@export var camara : Camera2D

@export var area_next_level : Area2D
@export_file("*.tscn") var next_level

@export var death_zone : Area2D
@export var Respawn : Node2D
var zonas_respawn : Array[Marker2D] = []

func _ready():
	for i in get_tree().get_nodes_in_group("paso_nivel"):
		i.destroy_respawn.connect(get_next_respawn)
	
	for child in Respawn.get_children():
		if child is Marker2D:
			zonas_respawn.append(child)
	
	Globales.current_level = self
	$Movimiento_plataformas.play("MovimientoPlataformas")

func _physics_process(_delta):
	for body in death_zone.get_overlapping_bodies():
		if body.is_in_group("jugador"):
			var current_respawn = zonas_respawn[0]
			Globales.jugador.global_position = current_respawn.global_position
	
	for body in area_next_level.get_overlapping_bodies():
		if body.is_in_group("jugador"):
			#print("next level")
			get_tree().change_scene_to_file(next_level)

func get_next_respawn():
	zonas_respawn.pop_front()
