extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var raw_damage = 0

func computeDamage() -> float:
	return getRawDamage()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setRawDamage(dmg:float):
	raw_damage = dmg

func getRawDamage() -> float:
	return raw_damage
