extends CharacterBody3D


var normal=Vector3()
var hight=Vector3()
var distance=0
var t=0

@onready var explos=preload("res://Enemies/demon_explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	velocity = normal - 2.0 * hight * t + hight * distance
	move_and_slide()
	t += delta
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("land"):
		print("hap")
		var boom=explos.instantiate()
		boom.position=global_position
		get_tree().get_root().call_deferred("add_child",boom)
		queue_free()
