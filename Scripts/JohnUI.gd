extends Control

@onready var HealthBar = $Health
@onready var HealthTimer = $HealthTimer

func _ready():
	HealthBar.max_value = get_owner().hp
	HealthBar.modulate = Color(1,1,1,0)

func UpdateHealth(hp):
	HealthBar.modulate = Color(1,1,1,1)
	create_tween().tween_property(HealthBar, "value", hp, .1)
	HealthTimer.stop()
	HealthTimer.start()

func _on_health_timer_timeout():
	var thetween = create_tween()
	thetween.tween_property(HealthBar, "modulate", Color(1,1,1,0), .5)
