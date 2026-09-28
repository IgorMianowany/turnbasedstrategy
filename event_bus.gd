extends Node

signal unit_selected
signal tile_clicked


var time : float = 0

func _process(delta: float) -> void:
	time += delta
