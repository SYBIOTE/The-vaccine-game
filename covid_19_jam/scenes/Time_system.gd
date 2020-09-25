extends Spatial

# Every 30 seconds is an hour
export var current_time = 0

var data = SimulationEngine.get_node("SaveAndLoadData")

func save_time():
	var world_data = data.wdata
	world_data["currentTime"] = current_time
	print(current_time)
	data.save_wdata


func _on_Timer_timeout():
	if current_time == 24:
		current_time = 0
	current_time += 1
	save_time()
