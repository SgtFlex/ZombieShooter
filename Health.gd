extends Node

class_name Health

signal health_depleted

@export var MAX_HEALTH := 100.0

var health : float
var MaxHealth = 100

func _ready():
	health = MAX_HEALTH

func Set_Health(NewHealth : float):
	health = NewHealth
	return health
	
func Get_Health():
	return health

func Take_Damage(damage: float) -> float:
	if (Set_Health(health - damage) <= 0):
		health_depleted.emit()
	return health
