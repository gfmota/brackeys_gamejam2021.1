extends KinematicBody2D

const ACCELERATION : int = 50
const GRAVITY : int = 20
const JUMP_HEIGHT : int = -550
const MAX_SPEED : int = 200
var friction : bool
var motion : Vector2
onready var dead : bool = false
onready var die_sfx : AudioStreamPlayer2D = $DieSFX
onready var jump_sfx : AudioStreamPlayer2D = $JumpSFX
onready var sprite : AnimatedSprite = $Sprite

func _physics_process(delta):
	if not dead:
		friction = false
		motion.y += GRAVITY
		# Horizontal moviment
		if Input.is_action_pressed("fire_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			sprite.flip_h = false
		if Input.is_action_pressed("fire_left"):
			motion.x = max (motion.x - ACCELERATION, -MAX_SPEED)
			sprite.flip_h = true
		else:
			friction = true
		# Jumping
		if is_on_floor():
			sprite.play("default")
			if Input.is_action_just_pressed("fire_up"):
				jump_sfx.play()
				motion.y += JUMP_HEIGHT
			if friction:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				sprite.play("jumping")
			if motion.y > 0:
				sprite.play("falling")
			if friction:
				motion.x = lerp(motion.x, 0, 0.2)
	else:
		motion = Vector2.ZERO
	motion = move_and_slide(motion, Vector2(0, -1),
					false, 4, PI/4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Body"):
			collision.collider.apply_central_impulse(-collision.normal * 50)

func die():
	die_sfx.play()
	dead = true
