extends Area2D


export var variant = 0

func _ready():
	if variant == 0:
		$AnimatedSprite.animation = "door_1"
	else:
		$AnimatedSprite.animation = "door_2"
