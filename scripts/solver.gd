extends Control

onready var MainPuzzle: Puzzle = $PuzzleGrid

func _ready():
	print(MainPuzzle.GameState)
	print("Print moves")
	
	var frontier := [MainPuzzle]
	var explored := []
	for x in range(10000):
		var node: Puzzle = frontier.pop_front()
		explored.append(node.get_state())
		
		var possible_moves := get_possible_moves(node)
		for move in possible_moves:
			if move.get_state() in explored:
				move.free()
			else:
				frontier.append(move)
	print("done")
	print(len(frontier))
	print(len(explored))
	

func get_possible_moves(puzzle: Puzzle) -> Array:
	var possible_moves = []
	
	if puzzle.EmptyTileIdx >= 3:
		var newPuzzle := Puzzle.new(puzzle.GameState)
		newPuzzle.handle_click(newPuzzle.get_child(puzzle.EmptyTileIdx-3))
		possible_moves.append(newPuzzle)
	
	if puzzle.EmptyTileIdx < 6:
		var newPuzzle := Puzzle.new(puzzle.GameState)
		newPuzzle.handle_click(newPuzzle.get_child(puzzle.EmptyTileIdx+3))
		possible_moves.append(newPuzzle)
		
	if (puzzle.EmptyTileIdx % 3) > 0:
		var newPuzzle := Puzzle.new(puzzle.GameState)
		newPuzzle.handle_click(newPuzzle.get_child(puzzle.EmptyTileIdx-1))
		possible_moves.append(newPuzzle)
	
	if (puzzle.EmptyTileIdx % 3) < 2:
		var newPuzzle := Puzzle.new(puzzle.GameState)
		newPuzzle.handle_click(newPuzzle.get_child(puzzle.EmptyTileIdx+1))
		possible_moves.append(newPuzzle)
	
	return possible_moves
