extends Node2D

var next_scene : String
onready var button_sfx : AudioStreamPlayer = $Main/ButtonSFX
onready var first : bool = true
onready var credits_btn : Button = $Main/Credits
onready var play_btn : Button = $Main/Play
onready var tween : Tween = $Tween

func _ready():
	if not MenuMusic.playing:
		MenuMusic.play()
	play_btn.connect("button_down", self, "on_play")
	credits_btn.connect("button_down", self, "on_credits")
	tween.connect("tween_all_completed", self, "tween_completed")
	tween.interpolate_property($Main, "scale", Vector2.ZERO, Vector2.ONE, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.interpolate_property($Main, "global_position", Vector2(448, 263), Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()

func on_play():
	button_sfx.play()
	tween.interpolate_property($Main, "scale", Vector2.ONE, Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.interpolate_property($Main, "global_position", Vector2.ZERO, Vector2(448, 263), 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	MenuMusic.stop()
	next_scene = "res://assets/scenes/Level1.tscn"

func on_credits():
	button_sfx.play()
	tween.interpolate_property($Main, "scale", Vector2.ONE, Vector2.ZERO, 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.interpolate_property($Main, "global_position", Vector2.ZERO, Vector2(448, 263), 0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	next_scene = "res://assets/scenes/Credits.tscn"

func tween_completed():
	if first:
		first = false
	else:
		get_tree().change_scene(next_scene)
