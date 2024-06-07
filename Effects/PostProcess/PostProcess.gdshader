shader_type canvas_item;

uniform sampler2D screenTexture: hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noiseTexture: repeat_enable;
uniform float warpStrenght: hint_range(0.0, 1.0, 0.01);

void fragment() {
	float uOffset = texture(noiseTexture, UV + TIME * vec2(0.3f, 0.02f)).r * warpStrenght - 0.5 * warpStrenght;
	float vOffset = texture(noiseTexture, UV + TIME * vec2(0.03f, 0.4f)).g * warpStrenght - 0.5 * warpStrenght;
	
	COLOR = texture(screenTexture, SCREEN_UV + vec2(uOffset, vOffset));
	//COLOR = texture(noiseTexture, UV + TIME * vec2(0.3f, 0.02f));
}