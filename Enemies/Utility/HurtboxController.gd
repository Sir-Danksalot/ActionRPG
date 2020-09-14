extends Area2D

export(bool) var Hit_Effects = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var efSprite = $EffectSprite
onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	efSprite.set_visible(false)
	connect("area_entered",self,"_display_hit") # Replace with function body.
	efSprite.connect("animation_finished",self,"_hit_effect_done")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _display_hit(_area:Area2D)->void: #Triggers the hit animation
	if Hit_Effects:
		efSprite.set_frame(0)
		efSprite.set_visible(true)
		efSprite.play("Hit")
		audio.play()

func _hit_effect_done()->void:#Hides the hit sprite and stops animation
	efSprite.set_visible(false)
	efSprite.stop()

func setHitEffects(yeno:bool)->void:
	Hit_Effects = yeno
	
func getHitEffects() -> bool:
	return Hit_Effects

func _parent_death()->void:
	setHitEffects(false)
	set_deferred("monitoring",false)
	#set_deferred("monitorable",false)
