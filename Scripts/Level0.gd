extends CanvasLayer

func _ready():
	$Control/BG/LevelSelect.visible = false

func _on_start_pressed():
	$Control/BG/LevelSelect.visible = !$Control/BG/LevelSelect.visible

func _on_options_pressed():
	Manager.ReqOptions()

func _on_quit_pressed():
	Manager.ReqQuit()



func _on_practice_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelPractice.tscn")

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Videos/VideoIntro.tscn")

func _on_level_2_pressed():
	pass # Replace with function body.
