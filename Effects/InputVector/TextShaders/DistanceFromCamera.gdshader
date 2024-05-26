shader_type spatial;

uniform float minDistance = 2.0f;
uniform float maxDistance = 50.0f;

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0f)).xyz;
}

void fragment() {
	float dist = length(CAMERA_DIRECTION_WORLD - world_position);
	float value = (dist - minDistance) / maxDistance;
	float clampedValue = clamp(value, 0.0f, 1.0f);
	
	ALBEDO = vec3(clampedValue);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
