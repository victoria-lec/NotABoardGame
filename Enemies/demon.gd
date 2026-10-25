extends CharacterBody3D


@onready var nav=$NavigationAgent3D
@onready var monster=preload("res://Enemies/monster_enegy.tscn")
var ready_to_strike=false
var state=0
var health = 120
var charge_dir=Vector3()
#0:idle
#1:walking
#2:shooting
var speed=4

var max_ammo=30
var ammo=0




func _physics_process(delta: float) -> void:
	var destination=nav.get_next_path_position()
	var local_dest=destination-global_position
	var dir=local_dest.normalized()
	
	velocity=dir*speed
	
	if state==1:
		move_and_slide()
	
func _on_timer_timeout() -> void:
	if state==0:
		$RayCast3D.target_position=Globals.player_pos-global_position
		$RayCast3D.force_raycast_update()
		
		if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
			state=1
			$rattler_timer.start()
		
	elif state==1:
		speed=1
		nav.target_position=Globals.player_pos
		if ready_to_strike:
			$RayCast3D.target_position=Globals.player_pos-global_position
			$RayCast3D.force_raycast_update()
			if $RayCast3D.get_collider() and $RayCast3D.get_collider().is_in_group("player"):
				ready_to_strike=false
				state=2
				$AnimatedSprite3D.play("attack")


			
		
			
		
	
	
	


func ouch(damage):
	health -= damage
	if health < 1:
		queue_free()
	#add voice lines for damage


func _on_rattler_timer_timeout() -> void:
	ready_to_strike=true



	



func attack():
	var coin=randi_range(1,10)
	if coin==10:
		$AudioStreamPlayer3D.play()
	var can = monster.instantiate()
	get_tree().get_root().add_child(can)
	can.global_position = global_position

	var T := 1.5 #flight hime 
	var H := 3.0 #flight hight  
	var diff = Globals.player_pos - global_position

	can.distance =T
	can.normal =diff/T
	can.hight = Vector3(0, 4.0 * H / (T * T), 0)

func _on_animated_sprite_3d_animation_finished() -> void:
	if state==2:
		attack()
		$AnimatedSprite3D.play("neutral")
		await get_tree().create_timer(2.0).timeout
		$rattler_timer.start()
		state=1
		
