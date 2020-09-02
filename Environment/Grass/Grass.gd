extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = $Sprite
onready var animatedSprite = $AnimatedSprite
onready var shadowSprite = $ShadowSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite.set_visible(false)
	sprite.set_visible(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AnimatedSprite_animation_finished():
	queue_free() # Replace with function body.

func _on_Grass_area_entered(_area:Area2D): #Checks for player attack and begins destruction animation
	sprite.set_visible(false)
	shadowSprite.set_visible(false)
	animatedSprite.set_frame(0)
	animatedSprite.set_visible(true)
	animatedSprite.play("decay")
