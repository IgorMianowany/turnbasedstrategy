class_name Combat
extends Node3D

var tiles : Array[Tile]
var slime_scene := preload("res://slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tiles.append_array($Tiles.get_children())
	var counter = 0
	for tile in tiles:
		if counter > 9:
			break
		if counter % 2 == 0:
			tile.creature = slime_scene.instantiate()
			tile.add_child(tile.creature)
		counter += 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
