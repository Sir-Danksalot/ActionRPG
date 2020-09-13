extends Popup

func _on_Pause_button_pressed() -> void:
	get_tree().paused = true
	show()

func _Resume()-> void:
	hide()
	get_tree().paused = false

func _unhandled_key_input(_event) -> void:
	if Input.is_action_pressed("pause"):
		_on_Pause_button_pressed()

func _on_Main_Menu_pressed()->void:
	_Resume()
	get_tree().change_scene("res://Game_Menus/Main_Menu/Main_Menu.tscn") # Replace with function body.
