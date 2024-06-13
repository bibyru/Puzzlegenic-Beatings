extends CanvasLayer

func _on_close_pressed():
	get_parent().remove_child(self)

func _on_quit_pressed():
	Manager.ReqQuit()

func _on_main_menu_pressed():
	Manager.ReqMainMenu()

func _ready():
	if Manager.level == 1:
		$Control/Panel/Label.text = "Museum Fatahillah was originally\na city hall, built in 1701.\n\nToday, it's Jakarta's iconic\nhistorical museum.\n\nThe underground prison is\nespecially infamous for being\nextremely cramped and\nfull of horrors."
