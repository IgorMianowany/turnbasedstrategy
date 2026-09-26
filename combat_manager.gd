class_name CombatManager
extends Node3D

var tiles : Array[Tile]
var slime_scene := preload("res://slime.tscn")
var selected_unit : Unit

@onready var combat_movement = CombatMovementHelper.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("unit_selected", select_unit)
	EventBus.connect("tile_clicked", move_unit)
	
	tiles.append_array($Tiles.get_children())
	
	combat_movement.build_field(tiles, 9)
	
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
	
func move_unit(target_tile : Tile):
	if (not target_tile.can_move_to()):
		return
	var current_tile = selected_unit.get_parent()
	
	
	print(combat_movement.get_distance_between_tiles(current_tile, target_tile))
	current_tile.unit = null
	selected_unit.reparent(target_tile, false)
	target_tile.unit = selected_unit
	
