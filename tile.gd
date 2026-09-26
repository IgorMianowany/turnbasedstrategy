class_name Tile
extends Node3D

var unit : Unit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_unit(_unit : Unit):
	unit = _unit
	


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (not event.is_action_pressed("mouse_pressed")):
		return
	EventBus.tile_clicked.emit(self)
