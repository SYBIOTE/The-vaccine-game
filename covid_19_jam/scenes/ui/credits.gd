extends Control

onready var text=$background/text
onready var pdata = SimulationEngine.get_node("PlayerData")
onready var wdata = SimulationEngine.get_node("SaveAndLoadData").load_wdata()
func show_stats():
	text.text=""
	$AnimationPlayer.play("New Anim")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	SimulationEngine.get_node("PlayerData").preset()
	SimulationEngine.get_node("Calc").presets()
	
	if anim_name=="New Anim":
		Loader.goto_scene("res://scenes/ui/title.tscn")
	
