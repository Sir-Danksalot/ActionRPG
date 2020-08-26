extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var maxHealth
var health

signal dead

func getMaxHealth():
	return maxHealth

func setMaxHealth(mhp):
	maxHealth = mhp

func getHealth():
	return health

func setHealth(hp):
	health = min(hp, maxHealth)

func forceSetHealth(hp):
	health = hp
	
func checkDeath():
	if health <= 0:
		emit_signal("dead")
		
func damage(dmg):
	health -= dmg
	checkDeath()
