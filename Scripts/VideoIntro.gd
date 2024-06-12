extends Control

@onready var bus_music = AudioServer.get_bus_index("Music")

var musicvol

func _ready():
	musicvol = AudioServer.get_bus_volume_db(bus_music)
	AudioServer.set_bus_volume_db(bus_music, -100)
	$Label.modulate = Color(1,1,1,0)

func _input(event):
	if event.is_action_pressed("SkipVideo"):
		FinishedVid()
	else:
		if $Timer.is_stopped():
			$Timer.start()
			$Label.modulate = Color(1,1,1,1)


func _on_video_stream_player_finished():
	FinishedVid()


func FinishedVid():
	AudioServer.set_bus_volume_db(bus_music, musicvol)
	if name.contains("Intro"):
		get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
		Manager.PlayMusicGame()
	else:
		Manager.ReqStartPuzzle()


func _on_timer_timeout():
	$Label.modulate = Color(1,1,1,1)
	create_tween().tween_property($Label, "modulate", Color(1,1,1,0), 1)
