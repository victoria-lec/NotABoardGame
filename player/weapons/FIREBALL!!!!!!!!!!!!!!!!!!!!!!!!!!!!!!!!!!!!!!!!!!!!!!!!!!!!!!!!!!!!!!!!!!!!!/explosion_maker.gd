extends Area3D

@export var dir=0
@onready var smoke=preload("res://player/weapons/FIREBALL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/smoke_cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await  get_tree().create_timer(3.0).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position+=Vector3(0.5,0,0).rotated(Vector3.UP,deg_to_rad(dir))
	
	


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("land"):
		queue_free()


func _on_timer_timeout() -> void:
	
	var smoke_inst=smoke.instantiate()
	smoke_inst.position=global_position
	get_tree().get_root().call_deferred("add_child",smoke_inst)
