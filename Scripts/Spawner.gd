extends Node2D

func _ready():
	for i in range(get_child_count()):
		remove_child(get_child(i))
	
	Spawn()

func Spawn():
	var thug = load("res://Scenes/InGame/CharThug.tscn").instantiate()
	add_child(thug)
	thug.fromspawner = true
