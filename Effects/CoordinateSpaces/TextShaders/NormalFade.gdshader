shader_type spatial;

uniform sampler2D baseTexture;
uniform sampler2D overlayTexture;
uniform sampler2D normalMap: hint_normal;

varying vec3 world_normal;
varying vec3 world_tangent;
varying vec3 world_binormal;

void vertex() {
	world_normal = normalize(MODEL_MATRIX * vec4(NORMAL, 1.0f)).rgb;
	world_tangent = normalize(MODEL_MATRIX * vec4(TANGENT, 1.0f)).rgb;
	world_binormal = normalize(MODEL_MATRIX * vec4(BINORMAL, 1.0f)).rgb;
}

void fragment() {
	//ALBEDO = mix(baseColor, ovelayColor, world_normal.y).rgb;
	vec4 normal_tangent = texture(normalMap, UV);
	normal_tangent = normal_tangent * 2.0 - 1.0;
	
	mat3 tbn = mat3(
        world_tangent, 
        world_binormal, 
        world_normal
    );
	
	vec3 normal_world = normalize(tbn * normal_tangent.rgb);
	vec4 baseColor = texture(baseTexture, UV);
	vec4 overlayColor = texture(overlayTexture, UV);
	
	vec4 color = mix(baseColor, overlayColor, normal_world.y);
	ALBEDO = color.rgb;
}