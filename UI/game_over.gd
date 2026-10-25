extends Control


func _ready() -> void:
	
	for i in get_tree().get_root().get_children():
		
		if i.is_in_group("UI") or i.name=="Globals":
			pass
		else:
			i.queue_free()
			
	if Globals.scene_texture:
		$Sprite2D.texture=Globals.scene_texture
