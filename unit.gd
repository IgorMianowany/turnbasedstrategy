class_name Unit
extends Node3D

var area : Area3D
var is_selected : bool = false
var is_hovered : bool = false
var speed : int = 3
var unit_name : String = ""
var health : int = 1 : get = get_health
var is_dead : bool = false
var check_mouse_pos_cooldown : float = .5
var check_mouse_pos_timer : float = 0


@onready var healthbar : TextureProgressBar = $Sprite3D/SubViewport/VBoxContainer/MarginContainer/Healthbar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()
	EventBus.connect("unit_selected", _change_color)
	unit_name = "Unit" + str(EventBus.counter)
	healthbar.max_value = health
	
	
func _process(delta: float) -> void:
	check_mouse_pos_timer += delta
	if check_mouse_pos_timer > check_mouse_pos_cooldown and not is_selected and is_hovered:
		check_mouse_pos_timer = 0
		_on_area_3d_mouse_entered()
		#$Area3D.monitoring = false
		#get_tree().create_timer(.2)
		#$Area3D.monitoring = true
	healthbar.value = health

	
func _change_color(_unit : Unit):
	pass
	
func get_health() -> int:
	return health
	
	
func set_health(_health : int):
	health = _health
	
func take_damage(_damage : int):
	health -= _damage
	if health <= 0:
		is_dead = true


func _on_area_3d_mouse_entered() -> void:
	pass
	#if is_selected == true:
		#return
	#is_hovered = true
	#EventBus.not_selected_unit_hovered.emit(self)


func _on_area_3d_mouse_exited() -> void:
	if is_selected == true:
		return
	is_hovered = false
