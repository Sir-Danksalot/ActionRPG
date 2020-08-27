extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum{
	MOVE
	ROLL
	ATTACK
}

var Velocity = Vector2.ZERO
var Input_Vector = Vector2.ZERO
var Roll_Vector = Vector2.LEFT
var state = MOVE

export var Max_Velocity = 150
export var Acceleration = 600
export var Static_Friction = 1200
export var Kinetic_Friction = 300
export var Roll_Speed = 150

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var meleeCollision = $Melee_Controller
onready var meleeCollisionShape = $Melee_Controller/Melee_CollisionShape

# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.set_active(true) # Replace with function body.
	meleeCollisionShape.set_disabled(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	match state:
		MOVE:
			_move_state(delta)
		ROLL:
			_roll_state(delta)
		ATTACK:
			_attack_state(delta)

func _move_state(delta):
	Input_Vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	Input_Vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if Input_Vector == Vector2.ZERO:
		animationState.travel("idle_blend")
		Velocity = Velocity.move_toward(Vector2.ZERO, Static_Friction * delta)
	else:
		Roll_Vector = Input_Vector
		meleeCollision.setImpactDir(Input_Vector.normalized())
		animationTree.set("parameters/idle_blend/blend_position", Input_Vector)
		animationTree.set("parameters/run_blend/blend_position", Input_Vector)
		animationTree.set("parameters/attack_blend/blend_position", Input_Vector)
		animationTree.set("parameters/roll_blend/blend_position", Input_Vector)
		animationState.travel("run_blend")
		Velocity = Velocity.move_toward(Vector2.ZERO, Kinetic_Friction * delta)
		Velocity = Velocity.move_toward(Input_Vector.normalized() * Max_Velocity, Acceleration * delta)
	#print(Velocity)
	Velocity = move_and_slide(Velocity) #move_and_collide(Velocity * delta)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func _attack_state(_delta):
	Velocity = Vector2.ZERO
	animationState.travel("attack_blend")

func _attack_animation_finished():
	state = MOVE


func _roll_state(_delta):
	Velocity = Roll_Vector.normalized() * Roll_Speed
	animationState.travel("roll_blend")
	Velocity = move_and_slide(Velocity)

func _roll_animation_finished():
	state = MOVE
