extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum {ALIVE, DEAD}

export(int) var maxHealth
var health
var life

signal death

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

func checkDeath(): #Checks if dead and if a transition from Alive to Dead is detected emits the "death" signal
	if health <= 0:
		if life == ALIVE:
			emit_signal("death")
		life = DEAD
	else:
		life = ALIVE

func damage(dmg): #Reduces health and checks for death
	health -= dmg
	checkDeath()
