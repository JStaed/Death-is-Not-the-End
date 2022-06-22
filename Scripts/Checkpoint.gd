extends Area2D


export var spawnPos = Vector2(0, 0)

var active = false
var glow = false

func _process(_delta):
	if glow and Input.is_action_just_pressed("interact"):
		if !active:
			for c in get_node("..").get_children():
				c.active = false
			active = true
			get_node("../../PlayerController").spawnPos = spawnPos

func _on_body_entered(_body):
	glow = true
	$Sprite.material.set_shader_param("width", 1.5)


func _on_body_exited(_body):
	glow = true
	$Sprite.material.set_shader_param("width", 0)
