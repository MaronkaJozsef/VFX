shader_type canvas_item;

uniform sampler2D rainDripsTexture: repeat_enable;
uniform sampler2D dripMaskTexture: repeat_enable;
uniform sampler2D screenTexture: hint_screen_texture;

void fragment() {
	vec2 resolution = 1.0f / SCREEN_PIXEL_SIZE.xy;
	float aspectRatio = resolution.x / resolution.y;
	vec2 uv = UV * vec2(aspectRatio, 1.0f);
	
	vec4 dripColor = texture(rainDripsTexture, uv);
	
	float dripSpeed = 3.0f;
	float offsetMultiplier = TIME * dripColor.a * dripSpeed;
	float dripOffsetMask = texture(dripMaskTexture, vec2(offsetMultiplier * 0.2f) - uv).r;
	
	float dripMask = round(dripColor.b);
	vec2 dripNormal = dripColor.rg * 6.0f - 3.0f;
	vec2 offsetUV = dripOffsetMask * dripNormal * dripMask;
	
	COLOR = texture(screenTexture, UV + 0.05f * offsetUV);
}