extends CharacterBody3D


@onready var nav=$NavigationAgent3D

func _process(delta: float) -> void:
	pass



func _physics_process(delta: float) -> void:
	var destination=nav.get_next_path_position()
	var local_dest=destination-global_position
	var dir=local_dest.normalized()
	
	velocity=dir*3
	move_and_slide()
	
func _on_timer_timeout() -> void:
	nav.target_position=Globals.player_pos


func ouch(damage):
	queue_free()
