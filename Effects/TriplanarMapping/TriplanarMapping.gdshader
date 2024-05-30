shader_type spatial;

uniform sampler2D colorTexture;

varying vec3 worldNormal;
varying vec3 worldPosition;

void vertex() {
	worldNormal = (MODEL_MATRIX * vec4(NORMAL, 0.0f)).rgb;
	worldPosition = (MODEL_MATRIX * vec4(VERTEX, 1.0f)).rgb;
}

void fragment() {
	vec3 absNormal = abs(normalize(worldNormal));
	vec3 mask = pow(absNormal, vec3(16.0f));
	vec3 weight = mask / dot(mask, vec3(1.0f));
	
	vec4 textureX = texture(colorTexture, worldPosition.yz) * weight.x;
	vec4 textureY = texture(colorTexture, worldPosition.xz) * weight.y;
	vec4 textureZ = texture(colorTexture, worldPosition.xy) * weight.z;
	
	vec4 color = textureX + textureY + textureZ;
	
	ALBEDO = color.rgb;
}
