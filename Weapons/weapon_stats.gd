extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#signal weapon_broke

enum {MELEE, RANGED}

export(int) var raw_damage
export(int) var durability
var type
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setKind(kind):
	type = kind
	
func setRawDamage(dmg):
	raw_damage = dmg

func getRawDamage():
	return raw_damage