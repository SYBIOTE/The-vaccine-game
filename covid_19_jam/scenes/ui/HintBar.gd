extends Control

func show_hint(_hint):
	$ColorRect/HintLabel.show()
	$ColorRect/HintLabel.text = _hint
func reset():
	$ColorRect/HintLabel.hide()
