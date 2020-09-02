extends Area2D

var player:KinematicBody2D = null
var rawLastKnownPosition:Vector2
var lastKnownPosition:Vector2

signal player_detected
signal player_lost

func isPlayerDetected() -> bool:
	return player != null

func getPlayer() -> KinematicBody2D:
	return player

func getCurrentPlayerDir() -> Vector2:
	return self.get_global_position().direction_to(player.get_global_position())

func getPlayerDir() -> Vector2:
	if isPlayerDetected():
		return getCurrentPlayerDir()
	else:
		return getLastKnownPosition().normalized()

func getLastKnownPosition() -> Vector2:
	return rawLastKnownPosition - self.get_global_position()
	
func getRawLastKnownPosition() -> Vector2:
	return rawLastKnownPosition

func _ready():
# warning-ignore:return_value_discarded
	self.connect("body_entered",self,"_playerBodyDetected")
# warning-ignore:return_value_discarded
	self.connect("body_exited",self,"_playerBodyLeft")

#Next few need to be modified for multiplayer

func _playerBodyDetected(plyr:KinematicBody2D):
	player = plyr
	rawLastKnownPosition = player.get_global_position()
	emit_signal("player_detected")#,getLastKnownPosition())

func _playerBodyLeft(plyr:KinematicBody2D):
	rawLastKnownPosition = plyr.get_global_position()
	player = null
	emit_signal("player_lost")#,getLastKnownPosition())
