extends Node

var balls=0
var player_pos=Vector3()

var scene_texture
var burn_map
var burn_texture
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	burn_map   = Image.create(200,200, false, Image.FORMAT_RGBA8)
	burn_texture = ImageTexture.create_from_image(burn_map)
	burn_texture.update(burn_map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func circle(pos:Vector2):
	for x in burn_map.x:
		for y in burn_map.y:
			set_palette_RGB(Vector2(x,y), png_image.get_pixel(x,y))
