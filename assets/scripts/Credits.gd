extends Node2D

onready var first : bool = true
onready var back_btn : Button = $Main/Button
onready var button_sfx : AudioStreamPlayer = $Main/ButtonSFX
onready var tween : Tween = $Tween

func _ready():
	back_btn.connect("button_down", self, "on_back")
	tween.connect("tween_all_completed", self, "on_tween_completed")
	tween.interpolate_property($Main, "scale", Vector2.ZERO, Vector2.ONE, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.interpolate_property($Main, "global_position", Vector2(448, 263), Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()

func on_back():
	button_sfx.play()
	tween.interpolate_property($Main, "scale", Vector2.ONE, Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.interpolate_property($Main, "global_position", Vector2.ZERO, Vector2(448, 263), 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()

func on_tween_completed():
	if first:
		first = false
	else:
		get_tree().change_scene("res://assets/scenes/Menu.tscn")
