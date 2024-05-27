shader_type spatial;

uniform sampler2D colorTexture;

void fragment() {
	vec2 matCapUV = (NORMAL * vec3(0.5f, -0.5f, 0.0f) + 0.5f).xy;
	ALBEDO = texture(colorTexture, matCapUV).rgb;
	EMISSION = texture(colorTexture, matCapUV).rgb;
}