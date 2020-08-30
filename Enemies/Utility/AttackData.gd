extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var raw_damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	setRawDamage(1)

func computeDamage():
	return getRawDamage()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setRawDamage(dmg):
	raw_damage = dmg

func getRawDamage():
	return raw_damage
