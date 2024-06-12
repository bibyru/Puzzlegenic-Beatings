extends Node2D

func Execute():
	if $Timer.is_stopped():
		$AudioStreamPlayer.play()
		$Timer.start()

func _on_timer_timeout():
	get_parent().FinishLevelFinished()
