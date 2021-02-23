extends Area2D

signal close_the_gate
signal open_the_gate
var state : bool
onready var bodies_inside : int = 0
onready var sprite_full : Sprite = $Sprite1
onready var sprite_half : Sprite = $Sprite2
onready var tween : Tween = $Tween

func _ready():
	tween.connect("tween_all_completed", self, "on_tween_completed")
	tween.interpolate_property(sprite_full, "modulate:a", 0.8, 0, 1)
	tween.interpolate_property(sprite_half, "modulate:a", 0, 0.8, 1)
	tween.start()
	state = true
	
	self.connect("body_entered", self, "on_body_entered")
	self.connect("body_exited", self, "on_body_exited")

func on_tween_completed():
	if state:
		tween.interpolate_property(sprite_half, "modulate:a", 0.8, 0, 1)
		tween.interpolate_property(sprite_full, "modulate:a", 0, 0.8, 1)
		tween.start()
	else:
		tween.interpolate_property(sprite_full, "modulate:a", 0.8, 0, 1)
		tween.interpolate_property(sprite_half, "modulate:a", 0, 0.8, 1)
		tween.start()
	state = !state

func on_body_entered(body):
	bodies_inside += 1
	if bodies_inside == 1:
		modulate = Color(0, 1, 0)
		emit_signal("open_the_gate")

func on_body_exited(body):
	bodies_inside -= 1
	if bodies_inside == 0:
		modulate = Color(1, 0, 0)
		emit_signal("close_the_gate")
