extends Area2D
class_name Collectibles

@export var object_id : String
@export var object_vfx : String

const move_amplitude : float = 10.0
const move_speed : float = 2.0
var base_position : Vector2
var time : float  = 0.0 

const vfx_script : GDScript = preload("res://scripts/scenes/components/collectibles/item_vfx.gd")

func _ready():
	if Globales.object_inventory.has(object_id):
		queue_free()
	
	base_position = global_position
	
	for i in randi_range(0, 10):
		time += move_speed

func _process(delta : float):
	time += delta * move_speed
	global_position.y = base_position.y + sin(time) * move_amplitude
	
	for body in get_overlapping_bodies():
		if body.is_in_group("jugador"):
			grab_item()

func grab_item():
	if object_id:
		Globales.add_collectible(object_id)
	
	queue_free()

func grab_vfx(sprite : String):
	var vfx : Sprite2D = Sprite2D.new()
	
	vfx.texture = load(sprite)
	vfx.top_level = true
	vfx.set_script(vfx_script)
	get_tree().current_scene.add_child(vfx)
