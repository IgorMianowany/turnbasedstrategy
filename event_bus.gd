extends Node

signal unit_selected
signal tile_clicked

var counter : int = 0 : get = get_counter

func get_counter() -> int:
	counter += 1
	return counter
