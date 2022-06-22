extends KinematicBody2D


export var isActive = false

# false = demon, true = angel
export var character = false


const SPEED = 7500
const JPOW = -250
const GRAVITY = 500
var xMove = 0
var vel = Vector2.ZERO
var jump = false
var grounded = false

var idleAnim = "idle_1"
var runAnim = "run_1"
var jumpAnim = "jump_1"

onready var cam = get_node("../Camera1")

func _ready():
	if character:
		cam = get_node("../Camera2")
		idleAnim = "idle_2"
		runAnim = "run_2"
		jumpAnim = "jump_2"
	$Sprite.animation = idleAnim

func _process(_delta):
	if isActive:
		# Gets x axis value
		xMove = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
		if Input.is_action_just_pressed("jump"):
			jump = true
	
	if !grounded:
		$Sprite.animation = jumpAnim
	else:
		if xMove != 0:
			$Sprite.animation = runAnim
		else:
			$Sprite.animation = idleAnim
	
	if vel.x < 0:
		$Sprite.flip_h = true
	if vel.x > 0:
		$Sprite.flip_h = false

func _physics_process(delta):
	if jump:
		jump = false
		if grounded:
			vel.y = JPOW
	
	vel.y += GRAVITY * delta
	vel.x = lerp(vel.x, xMove * SPEED * delta, 0.2)
	vel = move_and_slide(vel, Vector2(0, -1))

func _on_ground(_body):
	grounded = true

func _off_ground(_body):
	grounded = false
