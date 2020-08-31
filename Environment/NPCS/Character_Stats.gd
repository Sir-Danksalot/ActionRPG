extends Node

enum {ALIVE, DEAD}

export(int) var maxHealth
var health
var life = ALIVE

signal health_changed(health)
signal death

func getMaxHealth():
	return maxHealth

func setMaxHealth(mhp):
	maxHealth = mhp

func getHealth():
	return health

func setHealth(hp):
	health = min(hp, maxHealth)
	emit_signal("health_changed",health)
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

func changeHealth(difference): #Reduces health and checks for death
	if difference != 0:
		health += difference
		emit_signal("health_changed",health)
	checkDeath()

func _on_Hurtbox_area_entered(hitbox): #Detects Collision from hitbox
	changeHealth(-1*hitbox.computeDamage())
