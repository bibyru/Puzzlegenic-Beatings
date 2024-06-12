extends CanvasLayer

func Disappear():
	get_parent().remove_child(self)

func _on_no_pressed():
	Manager.ReqMainMenu()
	Disappear()

func _on_yes_pressed():
	Manager.ReqReloadScene()
	Disappear()
