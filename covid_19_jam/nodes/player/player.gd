extends KinematicBody
onready var MOVE_SPEED=12
const JUMP_FORCE=30
const gravity=.98
const max_fall_speed=30
const M_LOOK_SENS=0.5
const V_look_sens=1
onready var y_vel=0
var jumped
onready var cam=$cam

var move_vec=Vector3(0, 0, 0)

func _ready(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_look_sens
		cam.rotation_degrees.x =clamp(cam.rotation_degrees.x,-45,90)
		rotation_degrees.y -= event.relative.x * M_LOOK_SENS
	

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
		print("left")
		move_vec.x-=1


func _physics_process(delta):

	usr_input()
	
	print(move_vec)
	
	move_vec= move_vec.normalized()
	move_vec=move_vec.rotated(Vector3(0,1,0),rotation.y)
	move_vec*= MOVE_SPEED
	move_vec.y = y_vel
	move_and_slide(move_vec,Vector3(0,1,0))
	
	
	var grounded = is_on_floor()
	if !grounded:
		y_vel-=gravity
	if grounded and Input.is_action_just_pressed("jump"):
		y_vel= JUMP_FORCE
	
	#if y_vel < -max_fall_speed:
	#	y_vel= -max_fall_speed
