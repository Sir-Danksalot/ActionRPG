extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum {ALIVE, DEAD}

export(int) var maxHealth
var health
var life

signal dead

func getMaxHealth():
	return maxHealth

func setMaxHealth(mhp):
	maxHealth = mhp

func getHealth():
	return health

func setHealth(hp):
	health = min(hp, maxHealth)
	checkDeath()

func forceSetHealth(hp):
	health = hp

func checkAlive():
	return life == ALIVE

func checkDeath():
	if health <= 0:
		if life == ALIVE:
			emit_signal("dead")
		life = DEAD
	else:
		life = ALIVE

func damage(dmg):
	health -= dmg
	checkDeath()
