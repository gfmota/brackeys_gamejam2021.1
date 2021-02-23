extends Area2D

onready var sfx : AudioStreamPlayer = $SFX
onready var sprite : AnimatedSprite = $Sprite

func open():
	sprite.play("open")
	sfx.play()
