extends KinematicBody2D

const ACCELERATION : int = 50
const GRAVITY : int = 20
const JUMP_HEIGHT : int = -550
const MAX_SPEED : int = 200
var friction : bool
var motion : Vector2
onready var sprite = $Sprite

func _ready():
	sprite.play("default")

func _physics_process(delta):
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
		if Input.is_action_just_pressed("fire_up"):
			motion.y += JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	motion = move_and_slide(motion, Vector2(0, -1))
