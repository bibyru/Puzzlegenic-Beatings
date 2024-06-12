extends Area2D

func Execute(dmg):
	get_owner().Hurt(dmg)
