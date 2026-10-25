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
		if body.is_in_group("player"):#extra grace
			#set ofsets
			print('hit player')
			var target_pos=to_local(body.global_position)
			var offsets=[]
			
			offsets.append(target_pos)
			var side := target_pos.cross(Vector3.UP).normalized()
			offsets.append(target_pos-side*0.4)
			offsets.append(target_pos+side*0.4)
			var exposed=false
			var falloff=0
			for off in offsets:
				
				var ray=RayCast3D.new()
				add_child(ray)
				ray.position+=Vector3(0,0.5,0)
				ray.target_position=off
				ray.force_raycast_update()
				var dist := global_position.distance_to(body.global_position)
				falloff = 1.0 - clampf(dist / $CollisionShape3D.shape.radius, 0.0, 1.0)
				if ray.get_collider() and ray.get_collider()==body:
					pass
				else :
					exposed=false
					break
			if exposed:
				body.ouch(damage*falloff)
				
		var ray=RayCast3D.new()
		add_child(ray)
		ray.position+=Vector3(0,0.5,0)
		ray.target_position=to_local(body.global_position)
		ray.force_raycast_update()
		var dist := global_position.distance_to(body.global_position)
		var falloff := 1.0 - clampf(dist / $CollisionShape3D.shape.radius, 0.0, 1.0)
		if ray.get_collider() and ray.get_collider()==body:
			body.ouch(damage*falloff)
			


func _on_timer_timeout() -> void:
	queue_free()
