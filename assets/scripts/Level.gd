extends Node2D

var fire_done : bool = false
var water_done : bool = false
onready var door : Area2D = $Door
onready var fade : Node2D = $Fade

func _ready():
	door.connect("body_entered", self, "entered_door")
	door.connect("body_exited", self, "exit_door")
	fade.connect("end_fade", self, "fade_ended")
	fade.fade_in(1)

func entered_door(body):
	if body.is_in_group("WaterHero"):
		water_done = true
	elif body.is_in_group("FireHero"):
		fire_done = true
	
	if water_done and fire_done:
		fade.fade_out()

func exit_door(body):
	if body.is_in_group("WaterHero"):
		water_done = false
	elif body.is_in_group("FireHero"):
		fire_done = false

func fade_ended():
	print("FOI")
