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

func _process(_delta: float) -> void:
	#color_move_range()
	pass

func select_unit(unit : Unit):
	unit.is_selected = true
	selected_unit = unit
	color_move_range()
	
	
func move_unit(target_tile : Tile):
	if (not target_tile.can_move_to()):
		return
	var current_tile = selected_unit.get_parent()
	
	current_tile.unit = null
	selected_unit.reparent(target_tile, false)
	target_tile.unit = selected_unit
	
func color_move_range():
	var starting_tile = selected_unit.get_parent()
	var distance : int
	for tile in tiles:
		distance = combat_movement.get_distance_between_tiles(starting_tile, tile)
		if (distance <= selected_unit.speed and tile.can_move_to()):
			tile.color(Color.GREEN_YELLOW)
		else:
			tile.color()
			
