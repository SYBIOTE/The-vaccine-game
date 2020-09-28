extends Control
var ready=false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_pressed():
	$discliamer.play("show_disclaimer")
	
	

func _on_quit_pressed():
	get_tree().quit()

func _input(event):
	
	if Input.is_action_just_pressed("interact") and ready:
		Loader.goto_scene("res://scenes/map/indoors/bed_room.tscn")


func _on_discliamer_animation_finished(anim_name):
	if anim_name=="show_disclaimer":
		$discliamer.play("show text")
	if anim_name=="show text":
		ready=true


