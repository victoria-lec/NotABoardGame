extends MeshInstance3D

var target=Vector3()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(target)
	var tw=create_tween()
	tw.tween_property(self,"transparency",1.0,0.3)
	await tw.finished
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
