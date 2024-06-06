shader_type spatial;
render_mode cull_front, unshaded;

uniform float offset: hint_range(0.0, 1.0, 0.001) = 0.1f;

void vertex() {
	VERTEX += NORMAL * offset;
}

void fragment() {
	ALBEDO = vec3(0);
}