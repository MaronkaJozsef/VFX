shader_type spatial;

uniform sampler2D albedo;
uniform float scaleX : hint_range(0.0, 10.0, 0.1) = 4.0;
uniform float scaleY : hint_range(0.0, 10.0, 0.1) = 4.0;

void vertex() {
	UV.x /= scaleX;
	UV.y /= scaleY;
}

void fragment() {
	ALBEDO = texture(albedo, UV).rgb;
}
