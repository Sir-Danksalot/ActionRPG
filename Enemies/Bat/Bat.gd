extends KinematicBody2D

enum {IDLE,WANDER,CHASE,TRACK}

var state = WANDER#IDLE
var velocity = Vector2.ZERO
var orientation = Vector2.ZERO
var player

export var Knockback = 150
export var Air_Friction = 300
export var Hover_Friction = 600
export var MaxHealth = 1.0
export var Chase_Speed = 120
export var thrust = 450
export var lastKnownPosTrackRadius = 30
export var Track_Speed = 60

onready var animSprite = $AnimatedSprite
onready var shadSprite = $ShadowSprite
onready var bodyStats = $BodyStats
onready var playerDetector = $PlayerDetector
onready var hurtboxController = $HurtboxController
onready var hitboxController = $HitboxController
#onready var detectionShape = $PlayerDetector/DetectionShape
# Called when the node enters the scene tree for the first time.
func _ready():
	animSprite.set_animation("Fly")
	animSprite.set_visible(true)
	animSprite._set_playing(true)
	shadSprite.set_visible(true)
	bodyStats.connect("death",self,"_on_BodyStats_death")
	bodyStats.connect("death",hitboxController,"_pacify")
	playerDetector.connect("player_detected",self,"_on_player_detected")
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
		WANDER:
			pass
		CHASE:
			orientation = playerDetector.getPlayerDir()
			velocity = velocity.move_toward(orientation * Chase_Speed, thrust * delta)
		TRACK:
			if self.get_global_position().distance_to(playerDetector.getLastKnownPosition()) >= lastKnownPosTrackRadius:
				velocity = velocity.move_toward(playerDetector.getPlayerDir() * Track_Speed, thrust * delta)
			else:
				state = IDLE

func _on_player_detected():#_relpos):
	state = CHASE

func _on_player_lost():#_lkp):
	state = TRACK

func _on_Hurtbox_area_entered(area): #Detects Collision from Player weapon
	velocity = area.getImpactDir() * Knockback

func _on_BodyStats_death(): #Called when "death" signal received by BodyStats, emitted the first time health goes <= 0
	thrust = 0
	self.set_collision_layer_bit(4,false)
	self.set_collision_mask_bit(1,false)
	animSprite.set_animation("Die")
	animSprite.set_frame(0)
	animSprite.connect("animation_finished",self,"_dying_complete")

func _dying_complete(): #Called when the bat dying animation has completed
	queue_free()
