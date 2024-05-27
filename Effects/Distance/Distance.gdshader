shader_type spatial;

varying vec3 local_position;

void vertex() {
	// Called for every vertex the material is visible on.
	local_position = VERTEX;
}

void fragment() {
	vec3 position1 = vec3(cos(TIME * 2.0f + 1.6f), sin(TIME), cos(TIME) * 0.2f) * 0.39f;
	float distance1 = distance(local_position, position1);
	vec3 color1 = vec3(1.0f, 0.0f, 0.0f) * (1.0f-smoothstep(0.1, 0.11, distance1));
	
	vec3 position2 = vec3(cos(TIME), sin(TIME), cos(TIME) * 0.2f) * 0.39f;
	float distance2 = distance(local_position, position2);
	vec3 color2 = vec3(0.0f, 1.0f, 0.0f) * (1.0f-smoothstep(0.1, 0.11, distance2));
	
	vec3 position3 = vec3(cos(TIME * 3.0f), sin(TIME * 2.0f), cos(TIME + 3.3f) * 0.1f) * 0.39f;
	float distance3 = distance(local_position, position3);
	vec3 color3 = vec3(0.0f, 0.0f, 1.0f) * (1.0f-smoothstep(0.1, 0.11, distance3));
	
	ALBEDO = color1 + color2 + color3;
	//ALBEDO = vec3(1.0f);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
