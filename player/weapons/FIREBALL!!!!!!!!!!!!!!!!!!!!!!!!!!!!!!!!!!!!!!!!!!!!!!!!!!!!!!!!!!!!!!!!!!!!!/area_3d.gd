extends Area3D

func on_body_entered(body):
	if body.is_in_group("land"):
		print('hit')
		body.set_shader_parameter("charred", 1)
