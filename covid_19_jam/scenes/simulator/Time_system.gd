extends Node

# Every 30 seconds is an hour
var wake_up=6
var travel_time=2
var work_time=1
var current_time 
var current_day=1
onready var data = get_parent().get_node("SaveAndLoadData")
onready var world_data = data.wdata

func _ready():
	current_time=wake_up

func save_time():
	world_data["currentTime"] = current_time
	data.save_wdata
	print(current_time)
	if current_time in [12]:
		SimulationEngine.get_node("Calc").calculate_ans(world_data)
func travel():
	current_time+=travel_time
	save_time()
func new_day():
	SimulationEngine.get_node("Calc").calculate_ans(world_data)
	print(world_data)
	current_day+=1
	current_time = wake_up
	save_time()
func work():
	current_time+=work_time
	save_time()
func _on_Timer_timeout():
	if current_time == 24:
		current_time = 0
		new_day()
	current_time += 1
	save_time()
