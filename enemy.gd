extends CharacterBody2D

@export var SPEED := 50

@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var player = GlobalVariables.get_player()


			
func _physics_process(delta):
	if (player):
		var direction = (player.position - position).normalized()
		velocity = direction * SPEED
	move_and_slide()


func _on_damage_area_area_entered(area):
	pass # Replace with function body.

func _on_health_health_depleted():
	queue_free() # Replace with function body.
