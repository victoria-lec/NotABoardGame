shader_type spatial;
uniform sampler2D albedo_texture : source_color, filter_linear_mipmap, hint_default_white;
uniform sampler2D noise:filter_nearest,repeat_enable;
uniform float charred;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex = texture(albedo_texture, UV);
	vec4 n = texture(noise,UV);
	ALBEDO = tex.rgb - charred*n.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
