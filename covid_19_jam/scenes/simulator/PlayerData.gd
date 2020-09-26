extends Node

var isWearingMask #Wearing a mask is a really important factor in deciding the totalRisk.
var infectionRisk #The risk of infection, this changes depending upon where the player is and also how clean he is.
var transmissionRisk =.05#The risk of the disease betting transmitted from one person to another.(5% as per research,2% with mask)
var cleanliness=0 #How clean the player keeps itself, more the better. but too much is harmful to health
var workLoad=10#The amount of work the player does, needed to make the vaccine, but too much and health declines.
# too less and the player gets kicked and dies of poor health as he/she becomes is unemployed and homeless.
var workdone=0 # the work done to finish cure
var Interaction_chance =.0003 #This is the amount of interaction the player has with other people
var gone_to_work=false
# some notes to be taken , 
#higher total population, means u know interact with less people(compared to total)
# so low interaction chance
#but , with lower population areas , ur more likely to interact with the people there
#so higher interaction chance

var health=1

var totalRisk #An accumulation of all the factors like wearing mask, cleanliness, health, etc.
# also the final deciding factor as to wether the player gets infected or not ( can never be 0 )


func calc_totalRisk(infected):
	infectionRisk=infected*Interaction_chance*transmissionRisk
	health=clamp(health,.1,5)
	totalRisk = (infectionRisk)/(health+cleanliness)
	if isWearingMask:
		totalRisk *= 0.6
	print("total risk", totalRisk)
	totalRisk=clamp(totalRisk,.00001,1)
	
	return totalRisk*100

func check_if_infected():
	var e=randf()
	print(e)
	if e<totalRisk:
		print("infected")
		return true
	else:
		print(" not infected")
		return false
