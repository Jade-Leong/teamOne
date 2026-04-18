extends CharacterBody2D

const SPEED = 1000.0
const JUMP_VELOCITY = -600.0
const GRAVITY_MULTIPLIER = 2.5
var is_dead = false

func _physics_process(delta: float) -> void:
	# STOP EVERYTHING if dead
	if is_dead:
		return

	# 1. APPLY GRAVITY
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_MULTIPLIER

	# 2. HANDLE JUMP
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	# 3. GET MOVEMENT DIRECTION
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. APPLY THE MOVEMENT
	move_and_slide()

	# 5. CHECK FOR OBSTACLE COLLISION
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("obstacle"):
			die()

func die():
	if is_dead:
		return  # already dying, ignore extra calls
	is_dead = true
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
