shader_type spatial;
render_mode unshaded;

uniform sampler2D colorTexture;

vec2 rotation(vec2 porint, float angle) {
	vec2 rotationX = vec2(cos(angle), -sin(angle));
	vec2 rotationY = vec2(sin(angle), cos(angle));
	mat2 rotationMatrix = mat2(rotationX, rotationY);
	
	return rotationMatrix * porint;
}

void fragment() {
	vec2 uv = UV - 0.5f;
	float strength = 1.0f - pow(distance(uv, vec2(0.0f)), 0.5f);
	float rotationCount = 6.0f;
	float fullRotation = 2.0f * PI;
	uv = rotation(uv, -fract(TIME * 0.1f) * fullRotation * rotationCount * strength) + 0.5f;
	
	ALBEDO = texture(colorTexture, uv).rgb;
	ALBEDO = vec3(uv, 0.0f);
}