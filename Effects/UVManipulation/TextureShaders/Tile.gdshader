shader_type spatial;

uniform sampler2D albedo;
uniform float tileX : hint_range(0.0, 10.0, 1.0) = 4.0;
uniform float tileY : hint_range(0.0, 10.0, 1.0) = 4.0;

void vertex() {
	UV.x *= tileX;
	UV.y *= tileY;
}

void fragment() {
	ALBEDO = texture(albedo, UV).rgb;
}
