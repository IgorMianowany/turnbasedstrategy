class_name Slime
extends Unit

var is_blue = true
@onready var mesh_instance : MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	health = 10
	
	
	super._ready()
	mesh_instance.mesh.material.albedo_color = Color.BLUE

func _change_color(unit : Unit):
	is_selected = unit == self
	if is_selected:
		mesh_instance.mesh.material.albedo_color = Color.RED
		is_blue = false
	else:
		mesh_instance.mesh.material.albedo_color = Color.BLUE
		is_blue = true
