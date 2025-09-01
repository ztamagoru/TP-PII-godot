extends Estado

func enter():
	#jugador.sprite.play("Jump")
	jugador.velocity.y = -jugador.impulso_salto
	
func physics_update(delta):
	jugador.velocity.y += jugador.gravedad * delta
	jugador.move_and_slide()
	
	var direccion = Input.get_axis("mover_izquierda", "mover_derecha")
	jugador.velocity.x = direccion * jugador.speed * delta
	
	if jugador.velocity.y > jugador.gravedad:
		get_parent().ir_a_estado_siguiente("Cayendo")
	
	if jugador.is_on_floor():
		get_parent().ir_a_estado_siguiente("Quieto")
