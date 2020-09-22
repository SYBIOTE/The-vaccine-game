extends Spatial

bool isWearingMask #Wearing a mask is a really important factor in deciding the totalRisk.
int infectionRisk #The risk of infection, this changes depending upon where the player is and also how clean he is.
int transmissionRisk #The risk of the disease betting transmitted from one person to another.
int cleanliness #How clean the player keeps itself, more the better. but too much is harmful to health
int workLoad #The amount of work the player does, needed to make the vaccine, but too much and health declines.
# too less and the player gets kicked and dies of poor health as he/she becomes is unemployed and homeless.
int lackOfInteraction  #This is the amount of interaction the player has with other people

int health

int totalRisk #An accumulation of all the factors like wearing mask, cleanliness, health, etc.
# also the final deciding factor as to wether the player gets infected or not ( can never be 0 )

func _ready():
	pass

func _process():
	pass

func calc_totalRisk(infectionRisk, transmissionRisk, cleanliness, health, isWearingMask, totalRisk):
	totalRisk = (infectionRisk + transmissionRisk - cleanliness - health)/2
	if isWearingMask:
		totalRisk *= 0.6
	else:
		if totalRisk < 0.9:
			totalRisk *= 1.5

	return totalRisk
