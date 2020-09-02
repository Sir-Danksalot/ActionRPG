extends Node2D
var start_position:Vector2
var target_position:Vector2
var choice_expired:bool

export(float) var wander_range
export(float) var choice_validity

onready var timer = $Timer

#signal wander_time(position)

func _ready():
	timer.connect("timeout",self,"_timer_done")
	choice_expired = true

func getChoiceExpired() -> bool:
	return choice_expired

func new_target():
	target_position = Vector2(rand_range(-wander_range, wander_range),rand_range(-wander_range,wander_range))
	choice_expired = false
	timer.start(choice_validity)
	#print("timer started")

func _timer_done():
	#print("timer done")
	choice_expired = true

func configure()-> Vector2:
	new_target()
	return target_position

func wanderChoice(states:Array):
	states.shuffle()
	return states.pop_front()
