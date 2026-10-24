extends Node3D

#connect to physics body
# Called when the node enters the scene tree for the first time.

@onready var parent=get_parent() as CharacterBody3D

var dir


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dir=parent.velocity.normalized()
	look_at(dir)
	if $bottom.get_collider():
		if $bottom.get_collider().is_in_group("land") and !$top.get_collider():
			parent.position+=Vector3(0,0.2,0)


	
