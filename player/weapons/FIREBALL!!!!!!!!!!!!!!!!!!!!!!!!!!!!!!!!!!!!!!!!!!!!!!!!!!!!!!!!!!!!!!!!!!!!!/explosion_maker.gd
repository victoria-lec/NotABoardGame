extends Area3D

@export var dir=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position+=Vector3(3,0,0).rotated(Vector3.UP,deg_to_rad(dir))


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("land"):
		queue_free()
