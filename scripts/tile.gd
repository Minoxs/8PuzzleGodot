class_name PuzzleTile
extends Button

var GameBoard: GridContainer
var EmptyTile: bool = true
var CurrentPos: Vector2
var ID: String

func set_text(label):
	EmptyTile = (label == "_") or (len(label.strip_edges()) == 0)
	text = label if not EmptyTile else " "
	ID = "_" if EmptyTile else text

func set_rect_size(sz: Vector2):
	rect_size = sz
	theme.get_default_font().size = sz.length() / 3

func set_pos(pos: Vector2):
	CurrentPos = pos

func _ready():
	GameBoard = get_parent()

func _on_PuzzleTile_pressed():
	if EmptyTile:
		return
	GameBoard.handle_click(self)
