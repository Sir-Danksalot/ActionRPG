extends Control

const height:int = 44
# Each heart is 15 wide
onready var maxHealth = $MaxHealth
onready var currentHealth = $CurrentHealth
# Called when the node enters the scene tree for the first time.

func setMaxHealth(hp:float):
	maxHealth.set("rect_size",Vector2(60 * hp,height))

func setCurrentHealth(hp:float):
	currentHealth.set("rect_size",Vector2(60 * hp,height))

func _on_health_changed(health:float):
	setCurrentHealth(health)
