extends Estado

func enter():
	jugador.sprite.play("quieto")
	jugador.velocity.x = 0

func physics_update(_delta):
	jugador.velocity.y = jugador.gravedad
	jugador.move_and_slide()
	
	if jugador.is_on_floor() and Input.is_action_pressed("salto"):
		get_parent().ir_a_estado_siguiente("Saltando")
	
	if not jugador.is_on_floor():
		get_parent().ir_a_estado_siguiente("Cayendo")
		
	if Input.is_action_pressed("mover_derecha") or Input.is_action_pressed("mover_izquierda"):
		get_parent().ir_a_estado_siguiente("Caminando")
	#if Input.is_action_just_pressed("atacar"):
		#get_parent().ir_a_estado_siguiente("Atacando")
