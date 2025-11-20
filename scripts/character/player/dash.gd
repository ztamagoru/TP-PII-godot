extends Estado

@export var anim : AnimationPlayer
@export var current_velocity : float = 0
var max_gravedad : float = 200

func enter():
	pass

func _physics_update(delta):
	jugador.sprite.play("dash")
	anim.play("current_velocity")
	jugador._can_dash = false
	#jugador.velocity.y += jugador.gravedad * delta
	if jugador.velocity.y >= max_gravedad:
		jugador.velocity.y = max_gravedad
	if jugador.sprite.flip_h:
		jugador.velocity.x = -current_velocity
	else:
		jugador.velocity.x = current_velocity
	if jugador.velocity.y <= -100:
		jugador.velocity.y = -100
	jugador.move_and_slide()
	await anim.animation_finished
	
	if jugador.is_on_floor():
		get_parent().ir_a_estado_siguiente("Quieto")
	else:
		get_parent().ir_a_estado_siguiente("Cayendo")
