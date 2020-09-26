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
var delay=false
func set_new_scene(scene_resource):
	timer.start()
	delay=false
	print("start")
	current_scene = scene_resource.instance()

func _on_AnimationPlayer_animation_finished(anim_name):
	if "fade"==anim_name:
		calc_show_data()
		set_process(true)
	if delay:
		get_node("/root").add_child(current_scene)

func _on_Timer_timeout():
	delay=true
	anim.play_backwards("fade")

func calc_show_data():
	var data=SimulationEngine.get_node("SaveAndLoadData").load_wdata()
	print(data)
	var string
#	SimulationEngine.get_node("Calc").calculate_ans(data)
	if SimulationEngine.get_node("PlayerData").workdone==SimulationEngine.get_node("PlayerData").workLoad:
		string="cure finished \n you win"
		loader=ResourceLoader.load_interactive("res://scenes/ui/title.tscn")
	elif SimulationEngine.get_node("PlayerData").check_if_infected():
		string="your infected \n game over"
		loader=ResourceLoader.load_interactive("res://scenes/ui/title.tscn")
	else:
		string="total population: "+str(data["totalPopulation"])+"\ninfected: "+str(data["totalInfected"])+"\nhealty: "+str(data["totalHealthy"])+"\n\n risk: "+str(data["infectionRiskPercent"]) +"%"
	$background/loading.text=string



