extends Area2D


export var spawnPos = Vector2(0, 0)
export var id = 0
export var variant = 0

var active = false
var glow = false

func _ready():
	if variant == 0:
		$Sprite.animation = "inactive_1"
	else:
		$Sprite.animation = "inactive_2"

func _process(_delta):
	if glow and Input.is_action_just_pressed("interact"):
		for c in get_node("..").get_children():
			if c.id != id:
				if c.variant == 0:
					c.get_node("Sprite").animation = "inactive_1"
				else:
					c.get_node("Sprite").animation = "inactive_2"
				c.active = false
			else:
				if c.variant == 0:
					c.get_node("Sprite").animation = "active_1"
				else:
					c.get_node("Sprite").animation = "active_2"
				c.active = true
		active = true
		get_node("../../PlayerController").spawnPos = spawnPos
		glow = false
		$Sprite.material.set_shader_param("width", 0)
		if variant == 0:
			$Sprite.animation = "active_1"
		else:
			$Sprite.animation = "active_2"

func _on_body_entered(_body):
	if !active:
		glow = true
		$Sprite.material.set_shader_param("width", 1)


func _on_body_exited(_body):
	glow = false
	$Sprite.material.set_shader_param("width", 0)
