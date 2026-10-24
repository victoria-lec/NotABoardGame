extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.play("default")
	await get_tree().create_timer(1.0).timeout
	var tw=create_tween()
	tw.tween_property($MeshInstance3D,"modulate:a",0.0,1.0)
	await tw.finished
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
