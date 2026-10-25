extends Node3D

@export var burning = false
var gone = 0
# Called when the node enters the scene tree for the first time.
func burn():
	burning=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if burning:
		gone+=0.4*delta
		$tree.get_active_material(0).set_shader_parameter("dissolve",gone)
		$tree_001.get_active_material(0).set_shader_parameter("dissolve",gone)
