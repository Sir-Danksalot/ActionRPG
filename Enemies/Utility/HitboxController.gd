extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var cooldown = 1

onready var timer = $Timer
onready var attackData = $AttackData
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_one_shot(true)
	#attackData.setRawDamage(1)

func Cooldown(time:float):
	set_deferred("monitorable",false)
	timer.start(time)
	yield(timer,"timeout")
	set_deferred("monitorable",true)

func computeDamage() -> float:
	Cooldown(cooldown)
	return attackData.computeDamage()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _pacify():
	set_deferred("monitorable",false)
	timer.set_paused(true)
