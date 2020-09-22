extends Spatial

public int totalPopulation
public int totalInfected
public int totalHealthy

public int infectionRiskPercent
private float percentOfTotalInfected

# This function will do things when this node is is put in the scene
func _ready():
	totalPopulation = 250
	int percentageOfGeneralPopulationInfected = 8
	percentageOfTotalInfected = percentageOfGeneralPopulationInfected


# This function will do all the calculations
func _process():
	pass

func calculate_ans():
	int i = 0
	while i < totalPopulation:
		int infectionRoll = random.randi_range(101)

		if infectionRoll < percentageOfTotalInfected:
			totalInfected += 1
		else:
			totalHealthy += 1

		percentageOfTotalInfected = (totalInfected / totalPopulation) * 100

		i += 1
