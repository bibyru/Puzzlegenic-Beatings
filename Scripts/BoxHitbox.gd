extends Area2D

var bodynode = []

func _on_area_entered(area):
	bodynode.append(area.get_owner())

func _on_area_exited(area):
	if !bodynode.is_empty():
		for i in range(bodynode.size()):
			if i < bodynode.size():
				if area.get_owner() == bodynode[i]:
					bodynode.erase(bodynode[i])
			else:
				break

func Execute():
	if !bodynode.is_empty():
		for i in range(bodynode.size()):
			get_owner().PlaySoundAttack()
			bodynode[i].Hurtbox.Execute(get_owner().dmg)
