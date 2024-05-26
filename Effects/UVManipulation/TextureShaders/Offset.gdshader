shader_type spatial;

uniform sampler2D albedo;
uniform float offsetX : hint_range(0.0, 1.0, 0.125) = 0.5;
uniform float offsetY : hint_range(0.0, 1.0, 0.125) = 0.5;

void vertex() {
	UV.x += offsetX;
	UV.y += offsetY;
}

void fragment() {
	ALBEDO = texture(albedo, UV).rgb;
}
