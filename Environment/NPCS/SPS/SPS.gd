extends KinematicBody2D

enum {IDLE, DIALOGUE, DEAD}

var state = IDLE

onready var tempSprite = $tempSprite

onready var hurtboxControl = $HurtboxController
onready var bodyStats = $BodyStats

func _ready():
	hurtboxControl.connect("area_entered",bodyStats,"_on_Hurtbox_area_entered")
	bodyStats.connect("death",self,"_on_Death")
	bodyStats.setHealth(bodyStats.getMaxHealth())

func _on_Death()->void:
	#thrust = 0
	#shadSprite.set_visible(false)
	self.set_collision_layer_bit(4,false)
	self.set_collision_mask_bit(1,false)
	self.set_collision_mask_bit(4,false)
	queue_free()
	#animSprite.set_animation("Die")
	#animSprite.set_frame(0)
	#audio.play()
	#animSprite.connect("animation_finished",self,"_dying_complete")
