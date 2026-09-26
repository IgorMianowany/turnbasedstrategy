class_name CombatMovementHelper
extends Node

var field : Dictionary[Vector2, Tile]
var field_size_x : int
var field_size_y : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func build_field(tiles : Array[Tile], field_size : int):
	field_size_x = field_size
	field_size_y = field_size
	var counter : Vector2 = Vector2.ZERO
	var offset : int = 0
	for x in field_size_x:
		for y in field_size_y:
			if counter.x <= field_size_x and counter.y <= field_size_y:
				field.set(Vector2(x, y), tiles[x+y + offset])
		offset += 8
		
		
func get_distance_between_tiles(tile1 : Tile, tile2 : Tile) -> int:
	var coords1 : Vector2 = field.find_key(tile1)
	var coords2 : Vector2 = field.find_key(tile2)
	return abs((coords1.x - coords2.x) + (coords1.y - coords2.y))
