extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#signal weapon_broke

enum {MELEE, RANGED}

export(float) var raw_damage
export(float) var durability
var type
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setKind(kind):
	type = kind
	
func setRawDamage(dmg:float):
	raw_damage = dmg

func getRawDamage() -> float:
	return raw_damage
