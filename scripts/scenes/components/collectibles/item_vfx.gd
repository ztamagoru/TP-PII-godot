extends Sprite2D

const time_limit : float = 1.0
var time_left : float = 0

const speed : float = 50.0
var current_speed : float = 0.0

const distance_from_player : int = 50

func _ready() -> void:
	if not is_instance_valid(Globales.jugador):
		queue_free()

func _process(delta : float):
	follow_player()
	move_up(delta)

func move_up(delta):
	current_speed += speed * delta
	global_position.y -= current_speed
	
	modulate.a -= speed * delta

func follow_player():
	global_position = Globales.jugador.global_position
	position.x += distance_from_player if Globales.jugador.velocity.x < 0 else -distance_from_player
