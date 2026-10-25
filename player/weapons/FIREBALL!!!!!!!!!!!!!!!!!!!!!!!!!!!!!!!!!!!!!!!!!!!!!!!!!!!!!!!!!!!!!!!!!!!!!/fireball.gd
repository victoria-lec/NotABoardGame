extends RigidBody3D

@onready var explosion=preload("res://player/weapons/FIREBALL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite3D.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("land"):
		var explo_inst=explosion.instantiate()
		explo_inst.position=global_position
		get_tree().get_root().call_deferred("add_child",explo_inst)
		
		queue_free()
