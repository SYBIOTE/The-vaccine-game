extends KinematicBody



export var MOVE_SPEED=4
const JUMP_FORCE=30
const gravity=.98
const max_fall_speed=30
const M_LOOK_SENS=0.5
const V_look_sens=1
onready var y_vel=0
var working=false
var jumped
var scale_factor=.03
var scale_mult=0
var sanitizer_use=true 
onready var cam=$cam
onready var ray=$cam/RayCast
onready var hintbar=$Control/HintBar
onready var statsbar=$Control/HintBar2
var move_vec=Vector3(0, 0, 0)


var random = RandomNumberGenerator.new()

func _ready():

	random.randomize()

	var pdata=SimulationEngine.get_node("PlayerData")
	if pdata.isWearingMask:
		$cam/mask.show()
	
	

func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_look_sens
		cam.rotation_degrees.x =clamp(cam.rotation_degrees.x,-65,90)
		rotation_degrees.y -= event.relative.x * M_LOOK_SENS
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		

func usr_input():
	
	move_vec = Vector3()
	# Take in put from user
	if Input.is_action_pressed("move_forward"):
		move_vec.z-=1
	if Input.is_action_pressed("move_backward"):
		move_vec.z+=1
	if Input.is_action_pressed("move_right"):
		move_vec.x+=1
	if Input.is_action_pressed("move_left"):
		move_vec.x-=1
	if Input.is_action_pressed("crouch"):
		scale_mult=-1
	if Input.is_action_just_released("crouch"):
		scale_mult=+1
func sight():
	var l_o_s = ray.get_collider()
	if ray.is_colliding():
#		print(l_o_s.name)
		match l_o_s.name:
			"door":
#				print("door detected")
				hintbar.show_hint("go to work?")
				if !SimulationEngine.get_node("PlayerData").gone_to_work:
					if Input.is_action_just_pressed("interact"):
						$Control/fade/fades.play("fade_out")
						SimulationEngine.get_node("Time_system").travel()
						
				else:
					statsbar.show_hint("already worked today")
			"sanitiser":
				if sanitizer_use:
					hintbar.show_hint("use sanitizer?")
				else:
					statsbar.show_hint("used sanitizer,risk lowered , use again in a while")
				if Input.is_action_just_pressed("interact"):
					sanitizer_use=false
					$sanitizer_cooldown.start()
					SimulationEngine.get_node("PlayerData").cleanliness+=.15
			"mask":
				print("mask detected")
				if $cam/mask.visible==false:
					hintbar.show_hint("wear mask?")
					if Input.is_action_just_pressed("interact"):
						$cam/mask.visible=true
						SimulationEngine.get_node("PlayerData").isWearingMask=true
				else:
					hintbar.show_hint("remove mask?")
					if Input.is_action_just_pressed("interact"):
						print("no")
						$cam/mask.visible=false
						SimulationEngine.get_node("PlayerData").isWearingMask=false
			"bed":
#				print("bed detected")
				hintbar.show_hint("call it a day?")
				if SimulationEngine.get_node("Time_system").current_time>18 and  SimulationEngine.get_node("PlayerData").gone_to_work:
				
					if Input.is_action_just_pressed("interact"):
						SimulationEngine.get_node("PlayerData").health+=.1
						new_day()
						Loader.calc_show_data()
						statsbar.show_hint("health recovered")
				else:
					statsbar.show_hint("too early to go to sleep")
			"computer":
#				print("computer detected")
				hintbar.show_hint("take a leave?")
				if SimulationEngine.get_node("Time_system").current_time<11:
					if Input.is_action_just_pressed("interact"):
						SimulationEngine.get_node("PlayerData").health+=.3
						statsbar.show_hint("health recovered")
						new_day()
				else:
					statsbar.show_hint("too late to send a leave application for today")
			"microscope":
				hintbar.show_hint("research cure?")
				if SimulationEngine.get_node("Time_system").current_time<20:
					if Input.is_action_just_pressed("interact"):
						SimulationEngine.get_node("PlayerData").health-=.05
						SimulationEngine.get_node("PlayerData").workdone+=0.1
						SimulationEngine.get_node("Time_system").work()
						statsbar.show_hint("cure progressed")
						$Control/fade/fades.play("fade_out")
						working = true
				else:
					statsbar.show_hint("too late to work")
			"clock":
				var hour = SimulationEngine.get_node("Time_system").current_time
				var minutes = SimulationEngine.get_node("Time_system/Timer").time_left*2
				hintbar.show_hint("the time is "+ str(hour)+":"+str(int(60-minutes)) )
			"lab door":
				hintbar.show_hint("go home?")
				if SimulationEngine.get_node("Time_system").current_time>=18:
					if Input.is_action_just_pressed("interact"):
						$Control/fade/fades.play("fade_out")
						SimulationEngine.get_node("Time_system").travel()
				else:
					statsbar.show_hint("cant leave before 6pm")
			"lab computer":
				hintbar.show_hint("cure progress : "+str(SimulationEngine.get_node("PlayerData").workdone*10)+"%")
			"testubes":
				hintbar.show_hint("change sample?")
				if SimulationEngine.get_node("Time_system").current_time<20:
					if Input.is_action_just_pressed("interact"):
						var x = rand_range(1, 10)
						if x > 7:
							SimulationEngine.get_node("PlayerData").workdone += 0.5
						elif x < 4:
							if SimulationEngine.get_node("PlayerData").workdone > 0:
								SimulationEngine.get_node("PlayerData").workdone -= 0.2
								SimulationEngine.get_node("Time_system").ch_sample()
								statsbar.show_hint("samples changed")
								$Control/fade/fades.play("fade_out")
								working = true
							else:
								pass
						else:
							pass
				else:
					statsbar.show_hint("Too late to work.")
				#by changing samples possibility for next work to give double result
			"StaticBody":
				hintbar.reset()
				statsbar.reset()
	else:
		statsbar.reset()
		hintbar.reset()
func _physics_process(delta):
	
	usr_input()
	crouch()
	
	move_vec= move_vec.normalized()
	move_vec=move_vec.rotated(Vector3(0,1,0),rotation.y)
	move_vec*= MOVE_SPEED
	move_vec.y = y_vel
	move_and_slide(move_vec,Vector3(0,1,0))
	sight()
#	var grounded = is_on_floor()
#	if !grounded:
#		y_vel-=gravity
#	if grounded and Input.is_action_just_pressed("jump"):
#		y_vel= JUMP_FORCE
	
	#if y_vel < -max_fall_speed:
	#	y_vel= -max_fall_speed
func crouch():
	scale.y+=scale_factor*scale_mult
	scale.y=clamp(scale.y,.3,.6)
	if scale.y==.6:
		scale_mult=0
	if scale.y==.3:
		scale_mult=0

func new_day():
	$Control/fade/fades.play("new_day")
	SimulationEngine.get_node("Time_system").new_day()
	SimulationEngine.get_node("PlayerData").gone_to_work=false
	$Control/fade/text.text="Day "+str(SimulationEngine.get_node("Time_system").current_day)

func _on_fades_animation_finished(anim_name):
	if anim_name =="fade_out":
		if !working:
			if get_parent().name=="doc_room":
				Loader.goto_scene("res://scenes/map/indoors/lab.tscn")
				SimulationEngine.get_node("PlayerData").gone_to_work=true
			elif get_parent().name=="Laboratory":
				Loader.goto_scene("res://scenes/map/indoors/bed_room.tscn")
		else:
			$Control/fade/fades.play("fade_in")
			working = false


func _on_sanitizer_cooldown_timeout():
	sanitizer_use=true


