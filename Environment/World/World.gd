extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playerStats = $YSort/Player/StatsController
onready var playerHealthUI = $PlayerHealthUI

# Called when the node enters the scene tree for the first time.
func _ready():
	playerStats.connect("health_changed",playerHealthUI,"_on_health_changed")
	configPlayerHealthUI()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func configPlayerHealthUI():
	playerHealthUI.setMaxHealth(playerStats.getMaxHealth())
	playerHealthUI.setCurrentHealth(playerStats.getHealth())
