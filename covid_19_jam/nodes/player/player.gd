extends KinematicBody
export var MOVE_SPEED=3
const JUMP_FORCE=30
const gravity=.98
const max_fall_speed=30
const M_LOOK_SENS=0.5
const V_look_sens=1
onready var y_vel=0
var jumped
var scale_factor=.03
var scale_mult=0
onready var cam=$cam
onready var ray=$cam/RayCast
onready var hintbar=$Control/HintBar
var move_vec=Vector3(0, 0, 0)





func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_look_sens
		cam.rotation_degrees.x =clamp(cam.rotation_degrees.x,-50,90)
		rotation_degrees.y -= event.relative.x * M_LOOK_SENS
#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		

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
			"sanitiser":
#				print("sanitizer detected")
				hintbar.show_hint("use sanitizer?")
			"mask":
#				print("mask detected")
				hintbar.show_hint("wear mask?")
			"bed":
#				print("bed detected")
				hintbar.show_hint("call it a day?")
			"computer":
#				print("computer detected")
				hintbar.show_hint("take a leave?")
			"microscope":
				hintbar.show_hint("research cure?")
			"clock":
				hintbar.show_hint("the time is time_var")
			"lab door":
				hintbar.show_hint("go home?")
			"lab computer":
				hintbar.show_hint("cure progress cure_var%")
			"testubes":
				hintbar.show_hint("change sample?")
			
			
	else:
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
