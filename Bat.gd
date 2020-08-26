extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animSprite = $AnimatedSprite
onready var shadSprite = $ShadowSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	animSprite.visible = true
	shadSprite.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HitboxController_area_entered(area):
	queue_free()
