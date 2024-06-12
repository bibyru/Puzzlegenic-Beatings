extends Node

@onready var MenuTryAgain = load("res://Scenes/Menu/MenuTryAgain.tscn")
@onready var MenuPuzzleComplete = load("res://Scenes/Menu/MenuPuzzleComplete.tscn")
@onready var MenuOptions = load("res://Scenes/Menu/MenuOptions.tscn")

var level = 0
var lastlevel = 1

var options
var resolution = Vector2(1920, 1080)

func _ready():
	PlayMusicMenu()
	DisplayServer.window_set_size(resolution)
	ReqOptions()


func PlayMusicMenu():
	$MusicMenu.play()
	$MusicGame.stop()
func PlayMusicGame():
	$MusicMenu.stop()
	$MusicGame.play()



func _input(event):
	if event.is_action_pressed("Esc"):
		ReqOptions()



func ReqOptions():
	if get_parent().get_child(1).name.contains("Vid"):
		return
	
	ReqPause()
	if options == null:
		options = MenuOptions.instantiate()
		get_parent().get_child(1).add_child(options)
	else:
		get_parent().get_child(1).remove_child(options)
		options = null

func ReqPause(num = 0):
	if num == 0:
		if get_tree().paused == false:
			get_tree().paused = true
		else:
			get_tree().paused = false
	else:
		get_tree().paused = true

func ReqQuit():
	ReqPause(1)
	get_tree().quit()


func ReqStartPuzzle():
	PlayMusicMenu()
	get_tree().change_scene_to_file("res://Scenes/Puzzle/PuzzleLevel1.tscn")

func ReqPuzzleComplete():
	get_parent().get_child(1).add_child(MenuPuzzleComplete.instantiate())

func ReqMenuTryAgain():
	get_parent().get_child(1).add_child(MenuTryAgain.instantiate())





func ReqMainMenu():
	get_tree().change_scene_to_file("res://Scenes/LevelStartMenu.tscn")

func ReqReloadScene():
	get_tree().reload_current_scene()

func ReqNextLevel():
	level += 1
	if level > lastlevel:
		get_tree().change_scene_to_file("res://Scenes/LevelStartMenu.tscn")
	get_tree().change_scene_to_file("res://Scenes/Level"+str(level)+".tscn")
