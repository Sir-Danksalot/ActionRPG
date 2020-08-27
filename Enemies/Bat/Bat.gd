extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO

export var Knockback = 150
export var Air_Friction = 300
export var MaxHealth = 1.0

onready var animSprite = $AnimatedSprite
onready var shadSprite = $ShadowSprite
onready var bodyStats = $BodyStats
# Called when the node enters the scene tree for the first time.
func _ready():
	animSprite.set_animation("Fly")
	animSprite.set_visible(true)
	animSprite._set_playing(true)
	shadSprite.set_visible(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO,Air_Friction * delta)
	velocity = move_and_slide(velocity)


func _on_HitboxController_area_entered(area):
	bodyStats.damage(area.computeDamage())
	velocity = area.getImpactDir() * Knockback


func _on_BodyStats_dead():
	queue_free()
