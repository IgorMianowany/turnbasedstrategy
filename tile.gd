class_name Tile
extends Node3D

var is_showing_range : bool = false
var is_showing_selection : bool = false

var unit : Unit
@onready var mesh : Mesh = $MeshInstance3D.mesh

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	color()
	
func set_unit(_unit : Unit):
	unit = _unit

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (not event.is_action_pressed("mouse_pressed")):
		return
	EventBus.tile_clicked.emit(self)
	
func can_move_to() -> bool:
	return unit == null


func _on_area_3d_mouse_entered() -> void:
	if (not can_move_to()):
		return
	is_showing_selection = true
	#mesh.material.albedo_color = Color.GREEN

func _on_area_3d_mouse_exited() -> void:
	"""
		if tiles are stuck green, remove IF and hope performance is not tanking for some reason
	"""
	#if (not can_move_to()):
		#return
	is_showing_selection = false

	#mesh.material.albedo_color = Color.WHITE
	
func color(_color = null):
	if unit != null and unit.is_selected:
		mesh.material.albedo_color = Color.YELLOW
		return
	if is_showing_selection and not is_showing_range:
		mesh.material.albedo_color = Color.DIM_GRAY
		return
	if is_showing_selection:
		mesh.material.albedo_color = Color.GREEN
		return
	if is_showing_range:
		mesh.material.albedo_color = Color.GREEN_YELLOW
		return
	mesh.material.albedo_color = Color.WHITE
		
		
	#if _color == null:
		#pass
		##mesh.material.albedo_color = Color.WHITE
	#else:
		#mesh.material.albedo_color = _color
		
		
		

	

	


func _on_right_mouse_entered() -> void:
	#if unit != null:
	EventBus.attack_action_selected.emit(EventBus.DIRECTION.RIGHT, self)
	_on_area_3d_mouse_entered()
	
func _on_right_mouse_exited() -> void:
	#print("right exited")
	_on_area_3d_mouse_exited()


func _on_left_mouse_entered() -> void:
	#if unit != null:
	EventBus.attack_action_selected.emit(EventBus.DIRECTION.LEFT, self)
	_on_area_3d_mouse_entered()

func _on_left_mouse_exited() -> void:
	_on_area_3d_mouse_exited()


func _on_up_mouse_entered() -> void:
	#if unit != null:
	EventBus.attack_action_selected.emit(EventBus.DIRECTION.UP, self)
	_on_area_3d_mouse_entered()

func _on_up_mouse_exited() -> void:
	_on_area_3d_mouse_exited()

func _on_down_mouse_entered() -> void:
	#if unit != null:
	EventBus.attack_action_selected.emit(EventBus.DIRECTION.DOWN, self)
	_on_area_3d_mouse_entered()

func _on_down_mouse_exited() -> void:
	_on_area_3d_mouse_exited()


func _on_right_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_3d_input_event(camera, event, event_position, normal, shape_idx)

func _on_left_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_3d_input_event(camera, event, event_position, normal, shape_idx)


func _on_up_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_3d_input_event(camera, event, event_position, normal, shape_idx)


func _on_down_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	_on_area_3d_input_event(camera, event, event_position, normal, shape_idx)
