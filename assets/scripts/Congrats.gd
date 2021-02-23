extends Node2D

onready var first : bool = true
onready var button_sfx : AudioStreamPlayer = $Main/ButtonSFX
onready var menu_btn : Button = $Main/Button
onready var tween : Tween = $Tween

func _ready():
	InGameMusic.stop()
	MenuMusic.play()
	menu_btn.connect("button_down", self, "on_menu")
	tween.connect("tween_all_completed", self, "tween_completed")
	tween.interpolate_property($Main, "scale", Vector2.ZERO, Vector2.ONE, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.interpolate_property($Main, "global_position", Vector2(448, 263), Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()

func on_menu():
	button_sfx.play()
	tween.interpolate_property($Main, "scale", Vector2.ONE, Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.interpolate_property($Main, "global_position", Vector2.ZERO, Vector2(448, 263), 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()

func tween_completed():
	if first:
		first = false
	else:
		get_tree().change_scene("res://assets/scenes/Menu.tscn")
