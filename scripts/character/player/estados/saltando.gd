extends Estado

@export var particulas_salto : GPUParticles2D

func enter():
	print(name)
	jugador.sprite.play("saltando")
	jugador.velocity.y = -jugador.impulso_salto
	
func _physics_update(delta):
	jugador.velocity.y += jugador.gravedad * delta
	jugador.move_and_slide()
	
	var direccion = Input.get_axis("mover_izquierda", "mover_derecha")
	jugador.velocity.x = direccion * jugador.speed * delta
	
	if jugador.velocity.y <= 0:
		jugador.velocity.y += jugador.gravedad * delta
		
	if jugador.velocity.y > 0:
		get_parent().ir_a_estado_siguiente("Cayendo")
	
	if Input.is_action_just_pressed("dash") and jugador._can_dash and Globales.object_inventory.has("jetpack_dash") == true:
		get_parent().ir_a_estado_siguiente("Dash")
		return
	
	if jugador.is_on_floor():
		particulas_salto.restart()
		particulas_salto.emitting = true
		get_parent().ir_a_estado_siguiente("Quieto")
