extends Node

var loader
var wait_frames
var time_max = 100 # msec
var current_scene

onready var timer=$Timer
onready var anim=$AnimationPlayer

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	

func goto_scene(path): # game requests to switch to this scene
#	check_combat(current_scene.filename,"from")
#	check_combat(path,"to")
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		print("error")
		return

	current_scene.queue_free() # get rid of the old scene

	# start your load animation
	anim.play("fade")

	wait_frames = 1
func _process(time):
	if loader == null:
		set_process(false)
		return
	if wait_frames > 0:
		wait_frames -= 1
		return
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:

	# loading happens here
		var err = loader.poll()

		if err == ERR_FILE_EOF: # load finished
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			pass
			#included this if we put a bar / update anim later
			#update_progress()
		else: # error during loading
			print("error")
			loader = null
			break
#func update_progress():
#	var progress = float(loader.get_stage()) / loader.get_stage_count()
#	get_node("progress").set_progress(progress)
#
#	var length = get_node("animation").get_current_animation_length()
#
#	get_node("animation").seek(progress * length, true)
var delay=false
func set_new_scene(scene_resource):
	timer.start()
	delay=false
	print("start")
	current_scene = scene_resource.instance()

func _on_AnimationPlayer_animation_finished(anim_name):
	if "fade"==anim_name:
		set_process(true)
	if delay:
		get_node("/root").add_child(current_scene)

func _on_Timer_timeout():
	delay=true
	anim.play_backwards("fade")

#func check_combat(sc,key):
#	print(sc)
#	if sc == "res://scenes/game/combat/CombatScene.tscn":
#
#		if key =="to":
#			print("going to combat")
#			GlobalLocation.set_scene(current_scene.filename)
#		if key == "from":
#			print("coming from combat")
#			GlobalLocation.coming_from_encounter=true
#		else:
#			GlobalLocation.coming_from_encounter=false
		

