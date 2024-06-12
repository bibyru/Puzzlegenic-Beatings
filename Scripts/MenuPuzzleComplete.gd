extends CanvasLayer

func _on_close_pressed():
	get_parent().remove_child(self)

func _on_quit_pressed():
	Manager.ReqQuit()

func _on_main_menu_pressed():
	Manager.ReqMainMenu()
