extends Control

var pause = true

func _process(delta: float) -> void:
	if Input.is_action_just_released("pause"):
		pausing()

func pausing():
	#pause = not pause
	get_tree().paused = pause
	get_node(".").set_visible(pause)


#func _on_play_pressed():
#	#var dt = get_parent().get_parent().get_parent().get_parent().get_node("PlayerData").load_data(null, "user://save_temp.dat")
#	#print(dt)
#	get_tree().paused = false
#	get_node("..").set_visible(false)


func _on_quit_pressed() -> void:
	print("QUITTING...")
	get_tree().quit()


func _on_resume_pressed() -> void:
	get_tree().paused = false
	get_node(".").set_visible(false)
