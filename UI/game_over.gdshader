shader_type canvas_item;

uniform sampler2D sceen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 distort=vec2(SCREEN_UV.x,SCREEN_UV.y);
	distort.x+=sin(SCREEN_UV.y*10.0)*0.05;
	distort.y-=TIME;
	COLOR=textureLod(sceen_texture,distort,0.0);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
