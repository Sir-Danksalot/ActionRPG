extends "res://Weapons/weapon_stats.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setKind(MELEE)
	setRawDamage(1)

func computeDamage() -> float:
	return getRawDamage()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
