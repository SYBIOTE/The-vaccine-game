extends Node

var isWearingMask #Wearing a mask is a really important factor in deciding the totalRisk.
var infectionRisk #The risk of infection, this changes depending upon where the player is and also how clean he is.
var transmissionRisk #The risk of the disease betting transmitted from one person to another.
var cleanliness #How clean the player keeps itself, more the better. but too much is harmful to health
var workLoad #The amount of work the player does, needed to make the vaccine, but too much and health declines.
# too less and the player gets kicked and dies of poor health as he/she becomes is unemployed and homeless.
var lackOfInteraction  #This is the amount of interaction the player has with other people

var health

var totalRisk #An accumulation of all the factors like wearing mask, cleanliness, health, etc.
# also the final deciding factor as to wether the player gets infected or not ( can never be 0 )


func calc_totalRisk(infectionRisk, transmissionRisk, cleanliness, health, isWearingMask):
	var totalRisk = (infectionRisk + transmissionRisk - cleanliness - health)/2
	if isWearingMask:
		totalRisk *= 0.6
	else:
		if totalRisk < 0.9:
			totalRisk *= 1.5

	return totalRisk
