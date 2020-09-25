extends Spatial

# Every 30 seconds is an hour
export var current_time = 0

var data = SimulationEngine.get_node("SaveAndLoadData")
var world_data = data.wdata

func save_time():
	world_data["currentTime"] = current_time
	data.save_wdata
	print(current_time)
	if current_time	in [1, 5, 12, 19, 23]:
		SimulationEngine.get_node("Calc").calculate_ans(world_data)
		print(world_data)


func _on_Timer_timeout():
	if current_time == 24:
		current_time = 0
	current_time += 1
	save_time()
