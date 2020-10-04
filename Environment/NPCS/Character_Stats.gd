extends Node

enum {ALIVE, DEAD}

export(float) var maxHealth
var health:float
var life = ALIVE

signal health_changed(health)
signal death

func getMaxHealth() -> float:
	return maxHealth

func setMaxHealth(mhp:float):
	maxHealth = mhp

func getHealth() -> float:
	return health

func setHealth(hp:float):
	health = min(hp, maxHealth)
	emit_signal("health_changed",health)
	checkDeath()

func forceSetHealth(hp:float):
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

func changeHealth(difference:float): #Reduces health and checks for death
	if difference != 0:
		health += difference
		emit_signal("health_changed",health)
	checkDeath()

func _on_Hurtbox_area_entered(hitbox:Area2D): #Detects Collision from hitbox
	if hitbox.is_in_group("damaging"):
		changeHealth(-1*hitbox.computeDamage())
