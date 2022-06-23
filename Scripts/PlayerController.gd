extends Node2D


onready var players = [get_node("Player1"), get_node("Player2")]
onready var cams = [get_node("Camera1"), get_node("Camera2")]

export(int, 0, 1) var player = 0

export var spawnPos = Vector2(0, 0)

func _ready():
	players[0].position = spawnPos
	players[1].position = spawnPos + Vector2(0, -575)
	cams[0].position.y = 0

func _process(_delta):
	if Input.is_action_just_pressed("debug_switch"):
		_die()
	if Input.is_action_just_pressed("reset"):
		return get_tree().reload_current_scene()

func _die():
	for p in players:
		p.position.y = 2000
		p.grounded = false
		p.vel = Vector2.ZERO
	cams[0].current = true
	cams[1].current = false
	if player == 0:
		players[1].position = spawnPos + Vector2(0, -575)
		cams[0].get_node("AnimationPlayer").play("Up")
	else:
		players[0].position = spawnPos
		cams[0].get_node("AnimationPlayer").play("Down")

func _spawn_players(_anim):
	for p in players:
		p.grounded = false
		p.vel = Vector2.ZERO
		p.xMove = 0
		p.isActive = false

	if player == 0:
		player = 1
		players[0].position = spawnPos
		players[1].grounded = false
		players[1].isActive = true
		cams[0].current = false
		cams[1].current = true
	else:
		player = 0
		players[1].position = spawnPos + Vector2(0, -575)
		players[0].grounded = false
		players[0].isActive = true
		cams[1].current = false
		cams[0].current = true
