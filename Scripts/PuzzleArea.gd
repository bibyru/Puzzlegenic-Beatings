extends Area2D

var correct = false

func _on_area_entered(area):
	if area.get_owner().name == name:
		correct = true
		get_parent().get_parent().CheckAnswer()

func _on_area_exited(area):
	if area.get_owner().name == name:
		correct = false
