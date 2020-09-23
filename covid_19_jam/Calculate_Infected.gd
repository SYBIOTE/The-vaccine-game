extends Spatial

var random = RandomNumberGenerator.new()

var totalPopulationNum = 200
var totalInfected = 10
var totalHealthy = 0

var infectionRiskPercent
var percentOfTotalInfected


# This function will do things when this node is is put in the scene
func _ready():
	totalPopulationNum = 250
	random.randomize()

	totalInfected *= 100
	percentOfTotalInfected = totalInfected/totalPopulationNum
	totalInfected /= 100

	print("Initial percentOfTotalInfected: " + str(percentOfTotalInfected))

	calculate_ans()

func calculate_ans():
	var i = 0
	while i < totalPopulationNum:
		var infectionRoll = random.randi_range(1,101)
		#print(str(i) + ": " + "infectionRoll: " + str(infectionRoll) + " ; percentOfTotalInfected: " + str(percentOfTotalInfected))

		if infectionRoll < percentOfTotalInfected:
			totalInfected += 1
		else:
			totalHealthy += 1

		i += 1

	totalInfected *= 100
	percentOfTotalInfected = totalInfected/totalPopulationNum
	print("percentOfTotalInfected: " + str(percentOfTotalInfected))
