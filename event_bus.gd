extends Node

signal unit_selected
signal tile_clicked
signal not_selected_unit_hovered
signal attack_action_selected

enum DIRECTION {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

var counter : int = 0 : get = get_counter

func get_counter() -> int:
	counter += 1
	return counter
