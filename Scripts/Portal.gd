extends Area2D


export var variant = 0

onready var levels = [load("res://Scenes/Levels/Lvl1.tscn"), load("res://Scenes/Levels/Lvl2.tscn"), load("res://Scenes/Levels/Lvl3.tscn")]

func _ready():
	if variant == 0:
		$AnimatedSprite.animation = "door_1"
	else:
		$AnimatedSprite.animation = "door_2"




func _next_level(_body):
	Global.level += 1
	return get_tree().change_scene_to(levels[Global.level])
