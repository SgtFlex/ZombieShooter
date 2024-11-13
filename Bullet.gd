extends Area2D

@export var damage := 25.0
@export var speed := 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area):
	var HealthComp = area.get_parent().get_node("Health") as Health
	if (HealthComp):
		HealthComp.Take_Damage(damage)
	queue_free()
