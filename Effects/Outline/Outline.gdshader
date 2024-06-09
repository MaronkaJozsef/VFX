shader_type spatial;

render_mode cull_disabled, unshaded;

uniform sampler2D screenTexture: hint_screen_texture, filter_nearest;
uniform sampler2D worldNormal: hint_normal_roughness_texture, filter_nearest;
uniform sampler2D depthTexture: hint_depth_texture, filter_nearest;

const vec2[4] samplePositions = {vec2(-1, 1), vec2(1, -1), vec2(1, 1), vec2(-1, -1)};

float linearDepth(vec2 uv, mat4 inv_projection_matrix) {
	float depth = texture(depthTexture, uv).x;
	vec3 ndc = vec3(uv * 2.0 - 1.0, depth);
	vec4 view = inv_projection_matrix * vec4(ndc, 1.0);
	float linear_depth = -view.z / view.w;
	
	return -view.z / view.w;
}

void vertex() {
	POSITION = vec4(VERTEX, 1.0f);
}

void fragment() {
	const vec2 pixelSize = 1.0f / VIEWPORT_SIZE;
	
	float[4] depthSamples;
	for (int i = 0; i < 4; i++) {
		vec2 uv = SCREEN_UV + samplePositions[i] * pixelSize;
		depthSamples[i] = linearDepth(uv, INV_PROJECTION_MATRIX);
	}
	
	float diff1 = abs(depthSamples[0] - depthSamples[1]);
	float diff2 = abs(depthSamples[2] - depthSamples[3]);
	
	float edge = smoothstep(0.7f, 0.8f, diff1 + diff2);
	vec3 edgeColor = vec3(0.0f);
	
	vec4 screenColor = texture(screenTexture, SCREEN_UV);
	
	ALBEDO = mix(screenColor.rgb, edgeColor, edge);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
