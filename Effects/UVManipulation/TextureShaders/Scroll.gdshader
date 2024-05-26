shader_type spatial;

uniform sampler2D albedo;
uniform float speedX : hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float speedY : hint_range(0.0, 10.0, 0.1) = 1.0;

void vertex() {
	UV.x += TIME * speedX;
	UV.y += TIME * speedY;
}

void fragment() {
	ALBEDO = texture(albedo, UV).rgb;
}
