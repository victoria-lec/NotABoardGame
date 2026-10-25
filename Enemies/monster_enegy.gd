extends CharacterBody3D


var normal=Vector3()
var hight=Vector3()
var distance=0
var t=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	velocity = normal - 2.0 * hight * t + hight * distance
	move_and_slide()
	t += delta
	if t >= distance:
		queue_free() 
