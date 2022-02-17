class_name Puzzle
extends GridContainer

export var TileScene: String
var EmptyTileObj: PuzzleTile
var EmptyTileIdx := 8

func _ready():
	var TileSceneRes := load(TileScene)
	var pos := Vector2(0,0)
	
	for p in range(0, 9):
		var TileSceneInstance: PuzzleTile = TileSceneRes.instance()
		TileSceneInstance.set_rect_size(rect_size / columns)
		TileSceneInstance.set_pos(pos)
		TileSceneInstance.set_text(str(p+1) if p != 8 else " ")
		self.add_child(TileSceneInstance)
		
		pos.x = int(pos.x + 1) % 3
		if (p % 3) == 2:
			pos.y += 1
	EmptyTileObj = get_child(EmptyTileIdx)

func handle_click(tile: PuzzleTile):
	var pos := tile.CurrentPos
	var dist = pos - EmptyTileObj.CurrentPos
	if dist.length() == 1:
		# Calculate new tree index of empty tile
		var new_idx := int(pos.x + pos.y * 3)
		# Move in the vertical direction first if needed
		if dist.y != 0:
			move_child(tile, EmptyTileIdx)
		tile.set_pos(EmptyTileObj.CurrentPos)
		move_child(EmptyTileObj, new_idx)
		EmptyTileObj.set_pos(pos)
		EmptyTileIdx = new_idx

func _shuffle(num_shuffles: int):
	var children := get_children()
	var max_n := len(children)
	for x in range(num_shuffles):
		var pick := rand_range(0, max_n)
		handle_click(children[pick])

func _on_Button_pressed():
	_shuffle(Shuffles)
