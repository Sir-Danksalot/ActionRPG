extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var attack_direction:Vector2 = Vector2.ZERO
onready var wpnDat = $WeaponData
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func computeDamage() -> float:
	return wpnDat.computeDamage()

func setImpactDir(dir:Vector2):
	attack_direction = dir

func getImpactDir() -> Vector2:
	return attack_direction
