extends Node2D

@onready var enemy_scene = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func spawn():
	print_debug("Spawning enemy")
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	add_child(enemy)
	enemy.position = position

func _on_timer_timeout():
	spawn()
