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
}
