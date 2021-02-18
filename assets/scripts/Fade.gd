extends Node2D

signal end_fade
var finish : bool = false
onready var color_react : ColorRect = $ColorRect
onready var text : Label = $Text
onready var timer : Timer = $Timer
onready var tween : Tween = $Tween

func _ready():
	timer.connect("timeout", self, "timer_timeout")

func fade_in(level):
	text.text = "LEVEL " + str(level)
	tween.interpolate_property(text, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5)
	tween.start()
	timer.start()

func fade_out():
	text.text = ""
	tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1)
	tween.start()
	timer.start()
	finish = true

func timer_timeout():
	if not finish:
		tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5)
		tween.start()
	else:
		emit_signal("end_fade")
