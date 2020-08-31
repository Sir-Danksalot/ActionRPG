extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $YSort/Player
onready var playerStats = $YSort/Player/StatsController
onready var playerHealthUI = $CanvasLayer/PlayerHealthUI
onready var worldPOV = $WorldPOV
# Called when the node enters the scene tree for the first time.
func _ready():
	playerStats.connect("health_changed",playerHealthUI,"_on_health_changed")
	playerStats.connect("death",self,"_player_dead")
	_configPlayerHealthUI()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _configPlayerHealthUI():
	playerHealthUI.setMaxHealth(playerStats.getMaxHealth())
	playerHealthUI.setCurrentHealth(playerStats.getHealth())

func _player_dead():
	worldPOV.set_position(player.get_global_position())
	worldPOV.make_current()
