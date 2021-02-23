extends StaticBody2D

enum {
	OPEN,
	CLOSE,
	OPENING,
	CLOSING
}

const SPEED : int = 20
onready var collision : CollisionShape2D = $CollisionShape2D
onready var end : Position2D = $End
onready var raycast : RayCast2D = $RayCast2D
onready var sprite : Sprite = $Sprite
onready var state = CLOSE

func _process(delta):
	match state:
		OPEN:
			end.global_position.y = raycast.global_position.y
		CLOSE:
			end.global_position = raycast.get_collision_point()
		OPENING:
			end.global_position.y -= SPEED * delta
			if end.global_position.y <= raycast.global_position.y:
				state = OPEN
		CLOSING:
			end.global_position.y += SPEED * delta
			if end.global_position.y >= raycast.get_collision_point().y:
				state = CLOSE
	collision.global_position = (raycast.global_position + end.global_position) /2
	collision.shape.extents = Vector2(16, (end.global_position.y - raycast.global_position.y)/2)
	sprite.region_rect.end.y = end.position.length()

func _on_Button_close_the_gate():
	state = CLOSING

func _on_Button_open_the_gate():
	state = OPENING
