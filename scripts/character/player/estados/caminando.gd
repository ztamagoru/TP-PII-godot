extends Estado

func enter():
	print(name)
	jugador.sprite.play("caminando")

func update(delta):
	var direccion = Input.get_axis("mover_izquierda", "mover_derecha")
	
	jugador.velocity.x = direccion * jugador.speed * delta
	jugador.move_and_slide()
	
	if jugador.velocity.x == 0:
		get_parent().ir_a_estado_siguiente("Quieto")
		
	
	if not jugador.is_on_floor():
		get_parent().ir_a_estado_siguiente("Cayendo")
	if Input.is_action_pressed("salto"):
		get_parent().ir_a_estado_siguiente("Saltando")
	#if Input.is_action_just_pressed("atacar"):
		#get_parent().ir_a_estado_siguiente("Atacando")
