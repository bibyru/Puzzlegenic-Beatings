extends Area2D

var count = 0

func _on_body_entered(body):
	count+=1
	get_parent().canPan = false

func _on_body_exited(body):
	count-=1
	if count < 1:
		get_parent().canPan = true
