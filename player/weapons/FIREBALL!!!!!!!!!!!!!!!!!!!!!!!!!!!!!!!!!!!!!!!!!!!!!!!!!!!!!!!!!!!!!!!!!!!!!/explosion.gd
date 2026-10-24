extends Area3D



var damage=100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	
	if body.has_method("ouch"):
		
		$RayCast3D.target_position=body.global_position-global_position
		$RayCast3D.force_raycast_update()
		var dist := global_position.distance_to(body.global_position)
		var falloff := 1.0 - clampf(dist / $CollisionShape3D.shape.radius, 0.0, 1.0)
		if $RayCast3D.get_collider() and $RayCast3D.get_collider()==body:
			body.ouch(damage*falloff)
			
			



func _on_timer_timeout() -> void:
	queue_free()
