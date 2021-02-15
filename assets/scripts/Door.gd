extends Area2D

onready var sprite : AnimatedSprite = $Sprite

func open():
	sprite.play("open")
