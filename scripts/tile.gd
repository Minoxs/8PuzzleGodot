class_name PuzzleTile
extends Button

var GameBoard: GridContainer
var EmptyTile: bool = true
var CurrentPos: Vector2

func set_text(label):
	text = label
	EmptyTile = false

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
