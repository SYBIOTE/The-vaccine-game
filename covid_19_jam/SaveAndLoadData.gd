extends Spatial

var save_path = "user://save_temp.dat"

# Player data
var pdata = {
		"name" : "",
		"health" : 0,
		"totalRisk" : 0,
		"lackOfInteraction" : 0,
		"workLoad" : 0,
		"cleanliness" : 0,
		"infectionRisk" : 0,
		"transmissionRisk" : 0,
		"isWearingMask" : false,
		}

# World data
var wdata = {
		"totalPopulation" : 0,
		"totalInfected" : 0,
		"totalHealthy" : 0,
		"infectionRiskPercent" : 0,
		"percentageOfTotalInfected" : 0,
	}

func save_data(var dt = null):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(dt)
		file.close()

func load_pdata(var dt = null):
	var file = File.new()
	var p_data = null
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		print(error)
		if error == OK:
			p_data = file.get_var()
			file.close()
	return p_data

func load_wdata(var dt = null):
	var file = File.new()
	var w_data = null
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		print(error)
		if error == OK:
			w_data = file.get_var()
			file.close()
	return w_data
