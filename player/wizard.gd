extends CharacterBody3D

var speed=10
var base_speed=10
var max_speed=40

var damage=0
var Jumpforce=10
var mousedelta=Vector2()
var Sensetivity=10
var minlookangle: float = -90.0
var maxlookangle: float = 90.0

var guncooldown = 0
var guncooldown_timer=guncooldown
var altfirecooldown=0
var altfirecooldown_timer=0

var secondary_fire=false
var startup=true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var aimcast=$RayCast3D
@onready var camera=$Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	if speed<base_speed:
		speed=base_speed
	if speed>=max_speed:
		speed=max_speed
	speed-=0.03
	velocity.x/=1.1
	velocity.z/=1.1
	var input = Vector2()
	aimcast.rotation_degrees.x=0
	aimcast.rotation_degrees.y=0
	#imputs
	
	input.x =(Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * speed

	input.y=(Input.get_action_strength("move_down") - Input.get_action_strength("move_up")) * speed
	
	
	input=input.normalized()
	fire()
	#get directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativedir =  ( forward * input.y + right * input.x )
	
	#set velocity
	velocity.x=relativedir.x * speed
	velocity.z=relativedir.z * speed
	#apply gravity
	velocity.y-=gravity* delta
	
	#move player
	move_and_slide()
	
	
func _process(delta):
	#rotate camera x
	camera.rotation_degrees.x -= mousedelta.y * Sensetivity * delta
	
	
	#clamp camera x
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,minlookangle,maxlookangle)
	#rotate camera y
	rotation_degrees.y -= mousedelta.x*Sensetivity * delta
	
	
	#reset
	mousedelta=Vector2()

func _input(event):
	if event is InputEventMouseMotion:
		mousedelta =event.relative
		


func fire():
	guncooldown_timer+=1
	altfirecooldown_timer+=1
	if startup==true:
		
		altfirecooldown=120
		guncooldown=10
		damage=1
		startup=false
	
		
	if Input.is_action_just_released("shoot"):
		secondary_fire=false
		altfirecooldown_timer=0
		
	
