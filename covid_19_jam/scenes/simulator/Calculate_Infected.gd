extends Node

var random = RandomNumberGenerator.new()
onready var data = get_parent().get_node("SaveAndLoadData")
onready var player_data = get_parent().get_node("PlayerData")
export var totalPopulationNum : int
export var totalInfected : int 
export var use_presets: bool
var totalHealthy

var infectionRiskPercent
var percentOfTotalInfected

# This function will do things when this node is is put in the scene
func _ready():
	print(data.wdata)
	var world_data = data.wdata
	if use_presets:
		totalPopulationNum =  20000
		random.randomize()
		totalInfected = 4
		totalHealthy = totalPopulationNum - totalInfected
		world_data["totalInfected"] = totalInfected
		world_data["totalHealthy"] = totalHealthy
		world_data["totalPopulation"] = totalPopulationNum
		percentOfTotalInfected = (float(totalInfected)/float(totalPopulationNum))*100
		world_data["percentOfTotalInfected"] = percentOfTotalInfected
		world_data["infectionRiskPercent"] = player_data.calc_totalRisk(totalInfected)
	
	print("Initial percentOfTotalInfected: " + str(percentOfTotalInfected))
	var i = 0
	print("initial",world_data)
	while  i < 10:
		calculate_ans(world_data)
		player_data.check_if_infected()
		if world_data["totalInfected"]==world_data["totalPopulation"]:
			print("over at iteration",i)
			break
		i += 1
	print("final",world_data)
	
func calculate_ans(var world_data):
	var i = 0
	if world_data["totalInfected"]<world_data["totalPopulation"]:
		
		
		while i < totalPopulationNum:
			var infectionRoll = rand_range(0,101)
			#print(str(i) + ": " + "infectionRoll: " + str(infectionRoll) + " ; percentOfTotalInfected: " + str(percentOfTotalInfected))

			if infectionRoll < percentOfTotalInfected:
				totalInfected += 1

			i += 1

		

		totalHealthy = totalPopulationNum - totalInfected
		
	#	print("percentOfTotalInfected: " + str(percentOfTotalInfected))
		
		
		
		totalInfected = clamp(totalInfected,0,totalPopulationNum)
		world_data["totalInfected"] = totalInfected
		world_data["infectionRiskPercent"] = player_data.calc_totalRisk(totalInfected)
		totalHealthy = clamp(totalHealthy,0,totalPopulationNum)
		world_data["totalHealthy"] = totalHealthy
		world_data["totalPopulation"] = totalPopulationNum
		percentOfTotalInfected = (float(totalInfected)/float(totalPopulationNum))*100
		percentOfTotalInfected = clamp(percentOfTotalInfected,0,100)
		world_data["percentOfTotalInfected"] = float(percentOfTotalInfected)
		
		data.save_data(world_data, data.save_wdata)
	else:
		print("all infected")


	
