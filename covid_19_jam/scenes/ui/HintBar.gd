extends Control


func show_hint(_hint):
	$ColorRect/HintLabel.text = _hint
func reset():
	$ColorRect/HintLabel.text = "Use WASD to move around..."
