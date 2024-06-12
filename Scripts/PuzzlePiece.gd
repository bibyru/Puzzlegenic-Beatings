extends Node2D

func LoadTexture(textpath, myid):
	$Sprite2D.texture = load(textpath)
	name = myid

func _on_area_2d_mouse_entered():
	if get_parent().get_parent().OnMe == null:
		get_parent().get_parent().OnMe = self
		$Sprite2D.z_index = 2

func _on_area_2d_mouse_exited():
	if get_parent().get_parent().OnMe == self:
		get_parent().get_parent().OnMe = null
		$Sprite2D.z_index = 0
