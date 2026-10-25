extends StaticBody3D

func ouch(dam):
	$tree2.burn()
	$Timer.start(3.3)


func _on_timer_timeout() -> void:
	queue_free()
