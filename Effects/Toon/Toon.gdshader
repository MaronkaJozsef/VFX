shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

void light() {
	float intensity = dot(NORMAL, LIGHT) * 2.5f + 2.5f;
	float band = floor(intensity) * 0.2f;
	DIFFUSE_LIGHT = band * LIGHT_COLOR * 0.2f;
	
	vec3 specularReflection = reflect(LIGHT, NORMAL);
	float specular = clamp(dot(specularReflection, -VIEW), 0.0f, 1.0f);
	SPECULAR_LIGHT = round(pow(specular, 128.0f)) * LIGHT_COLOR * 0.5f;
}
