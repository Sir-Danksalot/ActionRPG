extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum{
	MOVE
	ROLL
	ATTACK
	DEAD
	DIALOGUE
}

var Velocity:Vector2 = Vector2.ZERO
var Input_Vector:Vector2 = Vector2.ZERO
var Roll_Vector:Vector2 = Vector2.LEFT
var state = MOVE

export(float) var Max_Velocity = 600
export(float) var Acceleration = 2400
export(float) var Static_Friction = 4800
export(float) var Kinetic_Friction = 1200
export(float) var Roll_Speed = 600

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var meleeCollision = $Melee_Controller
onready var meleeCollisionShape = $Melee_Controller/Melee_CollisionShape
onready var statsController = $StatsController
onready var hurtboxController = $HurtboxController
onready var sprite = $Sprite
onready var animSprite = $AnimationSprite
onready var shadSprite = $ShadowSprite
onready var deathAudio = $AnimationSprite/DeathSound
# Called when the node enters the scene tree for the first time.
func _ready():
	animSprite.set_visible(false)
	animationTree.set_active(true) # Replace with function body.
	meleeCollisionShape.set_disabled(true)
	statsController.connect("death",self,"_on_Death")
	statsController.connect("death",hurtboxController,"_parent_death")
	hurtboxController.connect("area_entered",statsController,"_on_Hurtbox_area_entered")

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
		DEAD:
			pass
		DIALOGUE:
			pass

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
	if state != DEAD:
		state = MOVE

func _roll_state(_delta):
	Velocity = Roll_Vector.normalized() * Roll_Speed
	animationState.travel("roll_blend")
	Velocity = move_and_slide(Velocity)

func _roll_animation_finished():
	if state != DEAD:
		state = MOVE

func _on_Death(): #Atm player dies before final hit animation plays, but can fix this by adding dying animation
	state = DEAD
	set_collision_layer_bit(1,false)
	set_collision_layer_bit(0,true)
	#set_collision_mask_bit()
	#print("Death Animation Plays")
	#hurtboxController.setHitEffects(false)
	_play_Death_Animation()
	yield(animSprite, "animation_finished") #ADD AN ACTUAL FOOKIN DEATH ANIMATION REEEEEEEEEE
	queue_free()

#func _on_Hurtbox_activated(hostile):
#	pass
func _play_Death_Animation():
	#animSprite.set_animation("Death")
	#animSprite.set_frame(0)
	#animSprite.connect("animation_finished",self,"_dying_complete")
	sprite.set_visible(false)
	animationPlayer.stop()
	shadSprite.set_visible(false)
	animSprite.set_visible(true)
	animSprite.play("death")
	deathAudio.play()
