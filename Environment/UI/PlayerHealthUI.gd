extends Control

const height = 11
# Each heart is 15 wide
onready var maxHealth = $MaxHealth
onready var currentHealth = $CurrentHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setMaxHealth(hp):
	maxHealth.set("rect_size",Vector2(15 * hp,height))

func setCurrentHealth(hp):
	currentHealth.set("rect_size",Vector2(15 * hp,height))

func _on_health_changed(health):
	setCurrentHealth(health)
