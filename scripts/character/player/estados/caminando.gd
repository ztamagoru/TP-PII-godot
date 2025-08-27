extends Estado

func enter():
	pass
	#jugador.sprite.play("Why are u runnin")

func update(delta):
	if Input.is_action_pressed("mover_derecha"):
		jugador.velocity.x = jugador.speed * delta
		jugador.move_and_slide()
		jugador.sprite.flip_h = false
	elif Input.is_action_pressed("mover_izquierda"):
		jugador.velocity.x = -jugador.speed * delta
		jugador.move_and_slide()
		jugador.sprite.flip_h = true
	else:
		get_parent().ir_a_estado_siguiente("Quieto")
	if not jugador.is_on_floor():
		get_parent().ir_a_estado_siguiente("Cayendo")
	if Input.is_action_pressed("salto"):
		get_parent().ir_a_estado_siguiente("Saltando")
	if Input.is_action_just_pressed("atacar"):
		get_parent().ir_a_estado_siguiente("Atacando")
