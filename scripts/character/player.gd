extends CharacterBody2D

var speed : float = 20000.0

func _process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed * delta
	
	move_and_slide()
