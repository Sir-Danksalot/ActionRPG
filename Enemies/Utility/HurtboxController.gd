extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var efSprite = $EffectSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",self,"_display_hit") # Replace with function body.
	efSprite.connect("animation_finished",self,"_hit_effect_done")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _display_hit(_area): #Triggers the hit animation
	efSprite.set_frame(0)
	efSprite.set_visible(true)
	efSprite.play("Hit")

func _hit_effect_done():#Hides the hit sprite and stops animation
	efSprite.set_visible(false)
	efSprite.stop()
