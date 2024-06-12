extends Camera2D

var enemycount = 0
var panDistance = 150



func _on_left_body_entered(body):
	Pan(-1)

func _on_right_body_entered(body):
	Pan(1)



func Pan(num):
	var finalpos = position.x + (num* panDistance)
	create_tween().tween_property(self, "position:x", finalpos, 1)
	
	Manager.ReqPause()
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = 1
	timer.start()
	timer.timeout.connect(TimerTimeout)

func TimerTimeout():
	Manager.ReqPause()
