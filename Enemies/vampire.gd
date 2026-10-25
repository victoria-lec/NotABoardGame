extends CharacterBody3D


@onready var nav=$NavigationAgent3D

var ready_to_strike=false
var state=0
var health = 200
var charge_dir=Vector3()
#0:idle
#1:walking
#2:shooting
var speed=4

var max_ammo=30
var ammo=0

func _process(delta: float) -> void:
	if state==0:
		$RayCast3D.target_position



func _physics_process(delta: float) -> void:
	var destination=nav.get_next_path_position()
	var local_dest=destination-global_position
	var dir=local_dest.normalized()
	
	velocity=dir*speed
	
	
	move_and_slide()
	
func _on_timer_timeout() -> void:
	if state==0:
		$RayCast3D.target_position=Globals.player_pos-global_position
		$RayCast3D.force_raycast_update()
		
		if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
			state=1
			$rattler_timer.start()
		
	elif state==1:
		speed=4
		nav.target_position=Globals.player_pos
		if ready_to_strike:
			$RayCast3D.target_position=Globals.player_pos-global_position
			$RayCast3D.force_raycast_update()
			if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
				ready_to_strike=false
				await get_tree().create_timer(0.3).timeout
				speed=6
				#animate
	elif state==2:
		nav.target_position=Globals.player_pos
		

			
		
			
		
	
	
	


func ouch(damage):
	health -= damage
	if health < 1:
		queue_free()
	#add voice lines for damage


func _on_rattler_timer_timeout() -> void:
	ready_to_strike=true


func tracer(target:Vector3):
	
	var dist=global_position.distance_to(target)
	if dist<=0.02:
		return
	$bullet.global_position=(global_position+target)/2.0
	$bullet.look_at(target)
	$bullet.scale.z=dist
	$bullet.show()
	await get_tree().create_timer(0.1).timeout
	$bullet.hide()
	


func attack():
	
	$Area3D.look_at(Globals.player_pos)
	$Area3D/CollisionShape3D2.disabled=false
	await get_tree().create_timer(0.1).timeout
	$Area3D/CollisionShape3D2.disabled=true

func _on_animated_sprite_3d_animation_finished() -> void:
	attack()
	speed=1
	await get_tree().create_timer(2.0).timeout
	$rattler_timer.start()
	state=1


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.ouch(30)
