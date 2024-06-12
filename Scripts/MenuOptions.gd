extends CanvasLayer

@onready var ButtonFullscreen = $Control/Panel/VBoxContainer/Fullscreen/MyButton
@onready var SliderMaster = $Control/Panel/VBoxContainer/Master/HSlider
@onready var SliderSound = $Control/Panel/VBoxContainer/Sound/HSlider
@onready var SliderMusic = $Control/Panel/VBoxContainer/Music/HSlider

var settingsContent : PackedStringArray
# 0 = Fullscreen, 1 = Master, 2 = Sound, 3 = Music

var ind_master = AudioServer.get_bus_index("Master")
var ind_sound = AudioServer.get_bus_index("Sound")
var ind_music = AudioServer.get_bus_index("Music")

var path = "user://Settings.txt"
# res://Files/Settings.txt
# user://Settings.txt




func _ready():
	var checkfile = FileAccess.open(path, FileAccess.READ)
	if checkfile == null:
		var newfile = FileAccess.open(path, FileAccess.WRITE)
		settingsContent = ["0","20","100","50"]
		newfile.store_csv_line(settingsContent)
		newfile.close()
		
	else:
		settingsContent = checkfile.get_csv_line()
		checkfile.close()
	
	for i in range(4):
		if i == 0:
			if settingsContent[i] == "1":
				if isFullscreen() == false:
					ButtonFullscreen.emit_signal("pressed")
				ButtonFullscreen.ButtonTextOn()
			
		if i == 1:
			SliderMaster.value = int(settingsContent[1])
		if i == 2:
			SliderSound.value = int(settingsContent[2])
		if i == 3:
			SliderMusic.value = int(settingsContent[3])




func isFullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		return true
	return false

func SaveToFile():
	var settingsWrite = FileAccess.open(path, FileAccess.WRITE)
	settingsWrite.store_csv_line(settingsContent)
	settingsWrite.close()




func _on_fullscreen_button_pressed():
	
	if isFullscreen() == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		settingsContent[0] = "1"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		settingsContent[0] = "0"
	
	SaveToFile()

func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(ind_master, linear_to_db(value * .01))
	settingsContent[1] = str(value)
	
	SaveToFile()

func _on_sound_value_changed(value):
	AudioServer.set_bus_volume_db(ind_sound, linear_to_db(value * .01))
	settingsContent[2] = str(value)
	
	SaveToFile()

func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(ind_music, linear_to_db(value * .01))
	settingsContent[3] = str(value)
	
	SaveToFile()




func _on_main_menu_pressed():
	Manager.ReqMainMenu()
	Manager.ReqPause()

func _on_quit_pressed():
	Manager.ReqQuit()

func _on_close_pressed():
	Manager.ReqOptions()

func _on_reset_pressed():
	Manager.ReqReloadScene()
	Manager.ReqPause()
