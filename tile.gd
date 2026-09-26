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
	
