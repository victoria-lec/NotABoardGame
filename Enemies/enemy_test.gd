extends CharacterBody3D


@onready var nav=$NavigationAgent3D
@onready var bullet=preload("res://Enemies/skelleton_bullet.tscn")
var ready_to_rattle=false
var state=0
var health = 60

#0:idle
#1:walking
#2:shooting


var max_ammo=30
var ammo=0





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
				rattle()

		
			
			
		
			
		
	
	
	
	
	


func rattle():
	$AnimatedSprite3D.play("new_animation")
	
	var cur_player_pos=Globals.player_pos
	var to_player = Globals.player_pos - global_position
	for i in 30:
		
		var dir = to_player.normalized()
		var side = dir.cross(Vector3.UP).normalized()

		
		var aim = cur_player_pos + side * randf_range(-1, 1)
		var shot_dir = (aim - global_position).normalized()
		var far_point = global_position + shot_dir * (to_player.length() + 2.0)

		$RayCast3D.target_position = $RayCast3D.to_local(far_point)
		$RayCast3D.force_raycast_update()

		if $RayCast3D.is_colliding():
			tracer($RayCast3D.get_collision_point())
			var c = $RayCast3D.get_collider()
			if c and c.is_in_group("player"):
				c.ouch(3)
		else:
			tracer(far_point)

		await get_tree().create_timer(0.05).timeout

	$rattler_timer.start()
	state = 1
		
	$AnimatedSprite3D.play("default")


func ouch(damage):
	health -= damage
	if health < 1:
		queue_free()
	#add voice lines for damage


func _on_rattler_timer_timeout() -> void:
	ready_to_rattle=true


func tracer(target:Vector3):
	var skel_bul=bullet.instantiate()
	var dist=global_position.distance_to(target)
	if dist<=0.02:
		return
	skel_bul.position=(global_position+target)/2.0
	skel_bul.target=target
	skel_bul.scale.z=dist
	get_tree().get_root().call_deferred("add_child",skel_bul)
	
