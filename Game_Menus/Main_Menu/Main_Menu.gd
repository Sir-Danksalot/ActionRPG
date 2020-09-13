extends MarginContainer


func _on_Controls_pressed() -> void:
	get_tree().change_scene("res://Game_Menus/Controls/Controls.tscn") # Replace with function body.


func _on_NewGame_pressed() -> void:
	get_tree().change_scene("res://Environment/World/World.tscn") # Replace with function body.
