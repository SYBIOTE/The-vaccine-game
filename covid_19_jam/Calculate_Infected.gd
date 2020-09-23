extends Spatial

var random = RandomNumberGenerator.new()
onready var data = get_parent().get_node("SaveAndLoadData")

var totalPopulationNum
var totalInfected
var totalHealthy

var infectionRiskPercent
var percentOfTotalInfected

# This function will do things when this node is is put in the scene
func _ready():

	print(data.wdata)
	var world_data = data.wdata

	totalPopulationNum = 250
	random.randomize()

	totalInfected = 10
	totalHealthy = 0

	totalInfected *= 100
	percentOfTotalInfected = totalInfected/totalPopulationNum
	totalInfected /= 100

	print("Initial percentOfTotalInfected: " + str(percentOfTotalInfected))

	calculate_ans(world_data)
	calculate_ans(world_data)

func calculate_ans(var world_data):
	var i = 0
	while i < totalPopulationNum:
		var infectionRoll = random.randi_range(1,101)
		#print(str(i) + ": " + "infectionRoll: " + str(infectionRoll) + " ; percentOfTotalInfected: " + str(percentOfTotalInfected))

		if infectionRoll < percentOfTotalInfected:
			totalInfected += 1

		i += 1

	totalInfected *= 100
	percentOfTotalInfected = totalInfected/totalPopulationNum
	totalInfected /= 100

	totalHealthy = totalPopulationNum - totalInfected

	print("percentOfTotalInfected: " + str(percentOfTotalInfected))
	world_data["percentOfTotalInfected"] = percentOfTotalInfected
	world_data["totalInfected"] = totalInfected
	world_data["totalHealthy"] = totalHealthy
	world_data["totalPopulation"] = totalPopulationNum

	data.save_data(world_data, data.save_wdata)
	print(world_data)
