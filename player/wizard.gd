extends CharacterBody3D

var speed=10
var base_speed=10
var max_speed=40

var health = 100

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


@onready var fireball=preload("res://player/weapons/FIREBALL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/fireball.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	Globals.player_pos=global_position
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
	

func _input(event):
	if event is InputEventMouseMotion:
		mousedelta =event.relative
	
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mousedelta += event.relative 

	# Esc releases the mouse (useful for debugging / pause menus)
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Click to recapture
	if event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_viewport().set_input_as_handled()

func _notification(what):
	
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _process(delta):
	#rotate camera x
	camera.rotation_degrees.x -= mousedelta.y * Sensetivity * delta
	
	
	#clamp camera x
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,minlookangle,maxlookangle)
	#rotate camera y
	rotation_degrees.y -= mousedelta.x*Sensetivity * delta
	
	
	#reset
	mousedelta=Vector2()

		


func fire():
	guncooldown_timer+=1
	altfirecooldown_timer+=1
	if startup==true:
		
		altfirecooldown=120
		guncooldown=10
		damage=1
		startup=false
	
		
	if Input.is_action_just_released("shoot"):
		var firball_inst=fireball.instantiate()
		get_tree().get_root().call_deferred("add_child",firball_inst)
		
		firball_inst.rotation=$Camera3D.rotation
		firball_inst.global_transform=$Camera3D.global_transform
		var dir=-$Camera3D.global_transform.basis.z
		firball_inst.apply_central_impulse(6.0*dir)
		
		secondary_fire=false
		altfirecooldown_timer=0
		
	

func ouch(dam):
	health -= dam
	if health < 0:
		health = 0
	$CanvasLayer/Label.text = ('Health: ' + str(health))
	if health < 1:
		print('dead :/')
