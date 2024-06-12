extends Node2D

@onready var LoadPiece = preload("res://Scenes/Puzzle/Piece.tscn")

var OnMe

var PieceIDs = [
	"11", "12", "13", "14", "15",
	"21", "22", "23", "24", "25",
	"31", "32", "33", "34", "35"
]

func _ready():
	CleanPieces()
	AddPieces()


func CleanPieces():
	for i in range(15):
		if PieceIDs[i][0] == "#":
			PieceIDs[i].replace("#","")


func RandomFloat():
	return randf_range(50,200)

func AddPieces():
	for i in range(15):
		var Piece = LoadPiece.instantiate()
		$Parent.add_child(Piece)
		Piece.global_position = $Parent.global_position + Vector2(RandomFloat(), RandomFloat())
		
		var randID = PieceIDs.pick_random()
		while (randID[0] == "#"):
			randID = PieceIDs.pick_random()
		
		for j in range(15):
			if randID == PieceIDs[j]:
				PieceIDs[j] = "#"+PieceIDs[j]
		
		var textPath = "res://Sauce/Sprites/Puzzle1/"+ randID +".png"
		
		Piece.LoadTexture(textPath, randID)



func CheckAnswer():
	for i in range(15):
		if $Areas.get_child(i).correct == false:
			return
	
	$FinishLevel.Execute()

func FinishLevelFinished():
	Manager.ReqPuzzleComplete()

func _physics_process(delta):
	if OnMe != null:
		if Input.is_action_pressed("Attack"):
			OnMe.global_position = get_global_mouse_position()
