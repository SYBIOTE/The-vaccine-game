extends KinematicBody
onready var MOVE_SPEED=12
const JUMP_FORCE=30
const gravity=.98
const max_fall_speed=30
const M_LOOK_SENS=1
const V_look_sens=1
onready var counter=0
var knocked=false
onready var y_vel=0
var interface
var energyball
var jumped
onready var cam=$cam
func _ready(): 
	pass
func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_look_sens
		cam.rotation_degrees.x =clamp(cam.rotation_degrees.x,-45,90)
		rotation_degrees.y -= event.relative.x * M_LOOK_SENS

func _physics_process(_delta):
	var move_vec=Vector3()
	var idle=true
	if Input.is_action_pressed("move_forward"):
		idle=false
		move_vec.z-=1
		MOVE_SPEED=16
	if Input.is_action_pressed("move_backward"):
		idle=false
		move_vec.z+=1
		MOVE_SPEED=11
	if Input.is_action_pressed("move_right"):
		idle=false
		move_vec.x+=1
		MOVE_SPEED=12
	if Input.is_action_pressed("move_left"):
		print("left")
		idle=false
		move_vec.x-=1
		MOVE_SPEED=12

	move_vec= move_vec.normalized()
	move_vec=move_vec.rotated(Vector3(0,1,0),rotation.y)
	move_vec*= MOVE_SPEED
	move_vec.y = y_vel
	move_and_slide(move_vec,Vector3(0,1,0))
	
	
	var grounded = is_on_floor()
	y_vel-=gravity
	if grounded and Input.is_action_just_pressed("jump"):
		jumped=true
		y_vel= JUMP_FORCE
	if grounded and y_vel<0:
		jumped=false
		y_vel =0
		
	if y_vel < -max_fall_speed:
		y_vel= -max_fall_speed
	




	









