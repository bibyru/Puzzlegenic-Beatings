extends Button

const ontext = " On"
const offtext = "Off"

func _ready():
	if toggle_mode == true:
		ButtonTextOff()

func _on_pressed():
	$AudioStreamPlayer.play()
	
	if toggle_mode == true:
		if text == ontext:
			ButtonTextOff()
		else:
			ButtonTextOn()

func ButtonTextOn():
	text = ontext

func ButtonTextOff():
	text = offtext
