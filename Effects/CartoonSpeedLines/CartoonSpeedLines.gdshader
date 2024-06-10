shader_type spatial;

render_mode unshaded, cull_disabled;

uniform sampler2D screenTexture: hint_screen_texture, filter_nearest;
uniform sampler2D noiseTexture;
uniform float lengthScale: hint_range(0.0, 5.0, 0.1);

void vertex() {
	POSITION = vec4(VERTEX, 1.0f);
}

void fragment() {
	float stepCount = 12.0f;
	float rotation = floor(fract(TIME * 0.8f) * stepCount) / stepCount * TAU;
	vec2 center = vec2(0.5, 0.5);
	vec2 shiftedUV = SCREEN_UV - center;

    float r = length(shiftedUV);
    float theta = atan(shiftedUV.y, shiftedUV.x) + rotation;

	float normalizedR = r / lengthScale;
	float normalizedTheta = theta * 2.5f;
	vec2 uv = vec2(normalizedR, normalizedTheta);
	
	float dist = distance(center, SCREEN_UV);
	float mask = 1.0f - (smoothstep(0.1f, 0.46f, dist) * 0.4);
	float falloffMask = mask + 0.25;
	
	float lines = smoothstep(mask, falloffMask, texture(noiseTexture, uv).r);
	
	ALBEDO = texture(noiseTexture, uv).rgb;
	ALBEDO = vec3(lines);
	vec3 lineColor = vec3(1.0f);
	ALBEDO = mix(texture(screenTexture, SCREEN_UV).rgb, lineColor, lines);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
