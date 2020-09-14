extends KinematicBody2D

enum {IDLE,WANDER,CHASE,TRACK}

var state = WANDER#IDLE
var velocity:Vector2 = Vector2.ZERO
var orientation:Vector2 = Vector2.ZERO
var wanderpos:Vector2 = Vector2.ZERO

export(float) var Knockback = 600
export(float) var Air_Friction = 1200
export(float) var Hover_Friction = 1800
#export(int) var MaxHealth = 1
export(float) var Chase_Speed = 480
export(float) var thrust = 1800
export(float) var lastKnownPosTrackRadius = 120
export(float) var Track_Speed = 240
export(float) var Wander_Speed = 120

onready var animSprite = $AnimatedSprite
onready var shadSprite = $ShadowSprite
onready var bodyStats = $BodyStats
onready var playerDetector = $PlayerDetector
onready var hurtboxController = $HurtboxController
onready var hitboxController = $HitboxController
onready var audio = $AudioStreamPlayer
onready var wanderController = $WanderController
#onready var rng = RandomNumberGenerator.new()
#onready var detectionShape = $PlayerDetector/DetectionShape
# Called when the node enters the scene tree for the first time.
func _ready():
	animSprite.set_animation("Fly")
	animSprite.set_visible(true)
	#animSprite.set_frame(randi_range(0,4))
	animSprite._set_playing(true)
	shadSprite.set_visible(true)
	bodyStats.connect("death",self,"_on_BodyStats_death")
	bodyStats.connect("death",hitboxController,"_pacify")
	bodyStats.connect("death",hurtboxController,"_parent_death")
	playerDetector.connect("player_detected",self,"_on_player_detected")
	playerDetector.connect("player_lost",self,"_on_player_lost")
	hurtboxController.connect("area_entered",self,"_on_Hurtbox_area_entered")
	hurtboxController.connect("area_entered",bodyStats,"_on_Hurtbox_area_entered")
	#hurtboxController.connect("area_entered",hurtboxController,"_display_hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO,Air_Friction * delta)
	velocity = move_and_slide(velocity)
	if velocity.length_squared() > 100:
		animSprite.set_flip_h(velocity.x < 0)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO,Hover_Friction * delta)
			_wander_choice()
			#if rng.randf() < 0.25:
				#orientation = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
				#state = WANDER
		WANDER: #IMPROVE THIS, Maybe a Raycast for no collision?
			velocity = velocity.move_toward(orientation * Wander_Speed,thrust * delta)
			_wander_choice()
			#if rng.randf() < 0.01:
			#	state = IDLE
		CHASE:
			orientation = playerDetector.getPlayerDir()
			velocity = velocity.move_toward(orientation * Chase_Speed, thrust * delta)
		TRACK:
			if playerDetector.getLastKnownPosition().length() >= lastKnownPosTrackRadius:
				velocity = velocity.move_toward(playerDetector.getPlayerDir() * Track_Speed, thrust * delta)
			else:
				state = IDLE

func _on_player_detected():#_relpos):
	state = CHASE

func _on_player_lost():#_lkp):
	state = TRACK

func _on_Hurtbox_area_entered(area:Area2D): #Detects Collision from Player weapon
	velocity = area.getImpactDir() * Knockback

func _on_BodyStats_death(): #Called when "death" signal received by BodyStats, emitted the first time health goes <= 0
	thrust = 0
	#shadSprite.set_visible(false)
	self.set_collision_layer_bit(4,false)
	self.set_collision_mask_bit(1,false)
	self.set_collision_mask_bit(4,false)
	animSprite.set_animation("Die")
	animSprite.set_frame(0)
	audio.play()
	animSprite.connect("animation_finished",self,"_dying_complete")

func _dying_complete(): #Called when the bat dying animation has completed
	queue_free()

func _wander_choice():
	if wanderController.getChoiceExpired():
		state = wanderController.wanderChoice([IDLE,WANDER])
		#print("State Chosen")
		if state == WANDER:
			orientation = wanderController.configure().normalized()
