class_name Unit
extends Node3D

var area : Area3D
var is_selected : bool = false
var speed : int = 3
var unit_name : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("unit_selected", _change_color)
	unit_name = "Unit" + str(EventBus.counter)


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (not event.is_action_pressed("mouse_pressed")):
		return
	#EventBus.emit_signal("unit_selected", self)
	
func _change_color(unit : Unit):
	pass
