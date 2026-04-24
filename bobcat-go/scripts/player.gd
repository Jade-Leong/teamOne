extends CharacterBody2D

const JUMP_VELOCITY = -900.0
const GRAVITY_MULTIPLIER = 2.5
const COYOTE_TIME := 0.1
const MAX_JUMPS := 2

var is_dead := false
var run_started_at_ms: int = 0
var coyote_timer := 0.0
var jumps_remaining := MAX_JUMPS

func _ready() -> void:
	run_started_at_ms = Time.get_ticks_msec()

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	# Gravity + coyote time tracking
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_MULTIPLIER
		coyote_timer -= delta
	else:
		coyote_timer = COYOTE_TIME
		jumps_remaining = MAX_JUMPS
	
	# Jump (first jump uses coyote time, subsequent jumps use jump counter)
	if Input.is_action_just_pressed("ui_accept"):
		if coyote_timer > 0.0:
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0.0
			jumps_remaining -= 1
		elif jumps_remaining > 0:
			velocity.y = JUMP_VELOCITY
			jumps_remaining -= 1
	
	# Lock horizontal position — Bobcat stays in place
	velocity.x = 0
	
	move_and_slide()
	
	# Obstacle collision
	for i in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider: Object = collision.get_collider()
		if collider and collider.is_in_group("obstacle"):
			die()
			break

func die():
	if is_dead:
		return
	is_dead = true
	get_node("/root/Game").end_run()

	var game = get_parent()
	if game and game.has_method("end_run"):
		game.end_run()
