extends CharacterBody3D


@onready var nav=$NavigationAgent3D

var ready_to_rattle=false
var state=0
var health = 60

#0:idle
#1:walking
#2:shooting


var max_ammo=30
var ammo=0

func _process(delta: float) -> void:
	if state==0:
		$RayCast3D.target_position



func _physics_process(delta: float) -> void:
	var destination=nav.get_next_path_position()
	var local_dest=destination-global_position
	var dir=local_dest.normalized()
	
	velocity=dir*3
	if state == 1:
		move_and_slide()
	
func _on_timer_timeout() -> void:
	if state==0:
		$RayCast3D.target_position=Globals.player_pos-global_position
		$RayCast3D.force_raycast_update()
		
		if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
			state=1
			$rattler_timer.start()
		
	elif state==1:
		nav.target_position=Globals.player_pos
		if ready_to_rattle:
			$RayCast3D.target_position=Globals.player_pos-global_position
			$RayCast3D.force_raycast_update()
			if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
				ready_to_rattle=false
				await get_tree().create_timer(0.3).timeout
				state=2
				
	elif state==2:
		ammo+=1
		$RayCast3D.target_position=Globals.player_pos-global_position
		$RayCast3D.force_raycast_update()
		if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
			$RayCast3D.get_collider().ouch(3)
			tracer(Globals.player_pos)
		if ammo>=max_ammo:
			state=1
			ammo=0
			$rattler_timer.start()
			
			
		
			
		
	
	
	


func ouch(damage):
	health -= damage
	if health < 1:
		queue_free()
	#add voice lines for damage


func _on_rattler_timer_timeout() -> void:
	ready_to_rattle=true


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
	
