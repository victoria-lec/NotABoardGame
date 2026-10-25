extends Area3D




#func _on_body_entered(body: Node3D) -> void:
	#if not body.is_in_group("land"):
		#print('hit')
		#body.get_parent().material.set_shader_parameter("Charred", 1)
