extends Node2D

export (int) var level_num
export (PackedScene) var next_scene
var fire_done : bool = false
var water_done : bool = false
onready var door : Area2D = $Door
onready var fade : Node2D = $Fade

func _ready():
	door.connect("body_entered", self, "entered_door")
	door.connect("body_exited", self, "exit_door")
	fade.connect("end_fade", self, "fade_ended")
	
	if get_node("Water") != null:
		get_node("Water").connect("body_entered", self, "on_water_body_entered")
	if get_node("Fire") != null:
		get_node("Fire").connect("body_entered", self, "on_fire_body_entered")
	
	fade.fade_in(level_num)

func entered_door(body):
	if body.is_in_group("WaterHero"):
		water_done = true
	elif body.is_in_group("FireHero"):
		fire_done = true
	
	if water_done and fire_done:
		door.open()
		fade.fade_out()

func exit_door(body):
	if body.is_in_group("WaterHero"):
		water_done = false
	elif body.is_in_group("FireHero"):
		fire_done = false

func fade_ended():
	get_tree().change_scene(next_scene.get_path())

func on_water_body_entered(body):
	if body.is_in_group("FireHero"):
		lose()

func on_fire_body_entered(body):
	if body.is_in_group("WaterHero"):
		lose()

func lose():
	print("perdeu")
