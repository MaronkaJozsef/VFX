shader_type spatial;

uniform sampler2D noise;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	float progress = sin(TIME) * 0.53f + 1.0f;
	
	vec4 map = texture(noise, UV);
	vec4 step1 = smoothstep(progress - 0.5f, progress - 0.47f, map);
	vec4 step2 = smoothstep(progress - 0.53f, progress - 0.52f, map);
	vec4 color = step2 - step1;
	
	ALBEDO = color.rgb;
}