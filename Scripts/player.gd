extends KinematicBody2D


var speed = 10000
var jPow = -350
var gravity = 500
var xMove = 0
var vel = Vector2.ZERO
var jump = false
var grounded = false

onready var coyote = get_node("Coyote")


func _process(_delta):
	# Gets x axis value
	xMove = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	if Input.is_action_just_pressed("jump"):
		jump = true

func _physics_process(delta):
	if jump:
		jump = false
		if grounded:
			vel.y = jPow
	
	vel.y += gravity * delta
	vel.x = lerp(vel.x, xMove * speed * delta, 0.2)
	vel = move_and_slide(vel, Vector2(0, -1))

func _on_ground(_body):
	grounded = true

func _off_ground(_body):
	coyote.start(0.075)

func _coyote():
	coyote.stop()
	if get_node("GndDetection").get_overlapping_bodies() == []:
		grounded = false
	else:
		grounded = true