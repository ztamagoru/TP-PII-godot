extends Estado

func enter():
	if jugador._can_dash == false:
		jugador._can_dash = true
	
	jugador.sprite.play("quieto")
	jugador.velocity.x = 0
	

func _physics_update(delta):
	if not jugador.is_on_floor():
		get_parent().ir_a_estado_siguiente("Cayendo")
		return
	
	jugador.velocity.y = jugador.gravedad
	jugador.move_and_slide()
	
	if Input.is_action_just_pressed("dash") and jugador._can_dash and Globales.object_inventory.has("jetpack_dash") == true:
		get_parent().ir_a_estado_siguiente("Dash")
		return
	
	if Input.is_action_pressed("salto"):
		get_parent().ir_a_estado_siguiente("Saltando")
		return
	
	if Input.is_action_pressed("mover_derecha") or Input.is_action_pressed("mover_izquierda"):
		get_parent().ir_a_estado_siguiente("Caminando")
	#if Input.is_action_just_pressed("atacar"):
		#get_parent().ir_a_estado_siguiente("Atacando")
