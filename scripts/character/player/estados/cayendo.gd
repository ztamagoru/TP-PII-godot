extends Estado

@export var particulas_salto : GPUParticles2D

func enter():
	print(name)
	jugador.sprite.play("cayendo")

func physics_update(delta):
	jugador.velocity.y += jugador.gravedad * delta
	
	var direccion = Input.get_axis("mover_izquierda", "mover_derecha")
	jugador.velocity.x = direccion * jugador.speed * delta
	
	jugador.move_and_slide()
	if jugador.is_on_floor():
		particulas_salto.restart()
		particulas_salto.emitting = true
		get_parent().ir_a_estado_siguiente("Quieto")
