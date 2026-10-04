class_name CombatManager
extends Node3D

var tiles : Array[Tile]
var slime_scene := preload("res://slime.tscn")
var selected_unit : Unit

var action_queue : Array[Unit] = []
var initiative_queue : Array[Unit] = []

@onready var combat_movement = CombatMovementHelper.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("unit_selected", select_unit)
	EventBus.connect("tile_clicked", move_unit)
	EventBus.connect("not_selected_unit_hovered", set_current_action)
	tiles.append_array($Tiles.get_children())
	combat_movement.build_field(tiles, 9)
	
	
	
	var counter = 0
	var unit : Unit
	for tile in tiles:
		if counter > 9:
			break
		if counter % 2 == 0:
			tile.unit = slime_scene.instantiate()
			tile.add_child(tile.unit)
			action_queue.append(tile.unit)
			initiative_queue.append(tile.unit)
			if (selected_unit == null):
				EventBus.unit_selected.emit(tile.unit)
				action_queue.erase(tile.unit)
		counter += 1
		

func _process(_delta: float) -> void:
	#color_move_range()
	pass

func select_unit(unit : Unit):
	if selected_unit != null:
		selected_unit.is_selected = false
	unit.is_selected = true
	selected_unit = unit
	selected_unit._change_color(unit)
	color_move_range()
	
	
func move_unit(target_tile : Tile):
	if (not target_tile.can_move_to() or not target_tile.is_showing_range):
		return
	var current_tile = selected_unit.get_parent()
	
	current_tile.unit = null
	selected_unit.reparent(target_tile, false)
	target_tile.unit = selected_unit
	target_tile.is_showing_selection = false
	
	selected_unit.take_damage(randi_range(0,10))
	

		
	if (action_queue.is_empty()):
			action_queue = initiative_queue.duplicate()
	while(not action_queue.is_empty()):
		selected_unit.is_selected = false
		selected_unit._change_color(selected_unit)
		selected_unit = action_queue.pop_front()
		if(selected_unit != null and not selected_unit.is_dead):
			selected_unit.is_selected = true
			break

			
	if (initiative_queue.find_custom(_filter_dead_units.bind()) == -1):
		get_tree().quit()
	
	selected_unit._change_color(selected_unit)
	color_move_range()
	
func _filter_dead_units(unit : Unit) -> bool:
	return not unit.is_dead and unit.health > 0
	
func color_move_range():
	var starting_tile = selected_unit.get_parent()
	var distance : int
	for tile in tiles:
		distance = combat_movement.get_distance_between_tiles(starting_tile, tile)
		if (distance <= selected_unit.speed and tile.can_move_to()):
			#tile.color(Color.GREEN_YELLOW)
			tile.is_showing_range = true
		else:
			tile.is_showing_range = false
			#tile.color()
			
func set_current_action(unit : Unit):
	var viewport := get_viewport()
	var mouse_position := viewport.get_mouse_position()
	var camera := viewport.get_camera_3d()
	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var ray_length := camera.far
	var end := origin + direction * ray_length
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	var result := space_state.intersect_ray(query)
	var mouse_position_3D:Vector3 = result.get("position", end)
	
	print(mouse_position_3D.direction_to(unit.global_position))
