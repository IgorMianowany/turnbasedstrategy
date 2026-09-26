class_name CombatManager
extends Node3D

var tiles : Array[Tile]
var slime_scene := preload("res://slime.tscn")
var selected_unit : Unit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("unit_selected", select_unit)
	EventBus.connect("tile_clicked", move_unit)
	
	
	tiles.append_array($Tiles.get_children())
	var counter = 0
	for tile in tiles:
		if counter > 9:
			break
		if counter % 2 == 0:
			tile.unit = slime_scene.instantiate()
			tile.add_child(tile.unit)
			if (selected_unit == null):
				EventBus.unit_selected.emit(tile.unit)
		counter += 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func select_unit(unit : Unit):
	unit.is_selected = true
	selected_unit = unit
	
func move_unit(tile : Tile):
	if (tile.unit != null):
		return
	(selected_unit.get_parent() as Tile).unit = null
	selected_unit.reparent(tile, false)
	(selected_unit.get_parent() as Tile).unit = selected_unit
	
