extends Area2D

var player = null
var rawLastKnownPosition
var lastKnownPosition

signal player_detected
signal player_lost

func isPlayerDetected():
	return player != null

func getPlayer():
	return player

func getCurrentPlayerDir():
	return self.get_global_position().direction_to(player.get_global_position())

func getPlayerDir():
	if isPlayerDetected():
		return getCurrentPlayerDir()
	else:
		return getLastKnownPosition().normalized()

func getLastKnownPosition():
	return rawLastKnownPosition - self.get_global_position()
	
func getRawLastKnownPosition():
	return rawLastKnownPosition

func _ready():
# warning-ignore:return_value_discarded
	self.connect("body_entered",self,"_playerBodyDetected")
# warning-ignore:return_value_discarded
	self.connect("body_exited",self,"_playerBodyLeft")

#Next few need to be modified for multiplayer

func _playerBodyDetected(plyr):
	player = plyr
	rawLastKnownPosition = player.get_global_position()
	emit_signal("player_detected")#,getLastKnownPosition())

func _playerBodyLeft(plyr):
	rawLastKnownPosition = plyr.get_global_position()
	player = null
	emit_signal("player_lost")#,getLastKnownPosition())
