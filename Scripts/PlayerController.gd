extends Node2D


onready var players = [get_node("Player1"), get_node("Player2")]
onready var cams = [get_node("Camera1"), get_node("Camera2")]

export(int, 0, 1) var player = 0

var spawnPos = Vector2(0, 0)

func _process(_delta):
	if Input.is_action_just_pressed("debug_switch"):
		die()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func die():
	for p in players:
		p.grounded = false
		p.velocity = Vector2.ZERO
	
	if player == 0:
		players[1].position = spawnPos + Vector2(575, 0)
		player = 1
		players[0].isActive = false
		players[1].isActive = true
		cams[0].current = false
		cams[1].current = true
	else:
		players[0].position = spawnPos
		player = 0
		players[1].isActive = false
		players[0].isActive = true
		cams[1].current = false
		cams[0].current = true
	
