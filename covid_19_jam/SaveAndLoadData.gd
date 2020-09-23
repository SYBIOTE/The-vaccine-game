extends Spatial

var save_pdata = "user://save_pdata.dat"
var save_wdata = "user://save_wdata.dat"

# Player data
export var pdata = {
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
export var wdata = {
		"totalPopulation" : 0,
		"totalInfected" : 0,
		"totalHealthy" : 0,
		"infectionRiskPercent" : 0,
		"percentOfTotalInfected" : 0,
	}

func save_data(var dt = null, var path = null):
	var file = File.new()
	var error = file.open(path, File.WRITE)
	if error == OK:
		file.store_var(dt)
		file.close()

func load_pdata():
	var file = File.new()
	var p_data = null
	if file.file_exists(save_pdata):
		var error = file.open(save_pdata, File.READ)
		print(error)
		if error == OK:
			p_data = file.get_var()
			file.close()
	return p_data

func load_wdata():
	var file = File.new()
	var w_data = null
	if file.file_exists(save_wdata):
		var error = file.open(save_wdata, File.READ)
		print(error)
		if error == OK:
			w_data = file.get_var()
			file.close()
	return w_data
