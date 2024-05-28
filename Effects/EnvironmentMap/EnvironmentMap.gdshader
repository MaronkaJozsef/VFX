shader_type spatial;
render_mode unshaded;

uniform sampler2D environment : filter_linear;
varying vec3 world_normal;
varying vec3 world_reflection;
varying vec3 world_position;

void vertex() {
	world_normal = normalize(MODEL_MATRIX * vec4(NORMAL, 1.0f)).rgb;
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0f)).rgb;
}

void fragment() {
	vec3 viewDirection = normalize(CAMERA_POSITION_WORLD - world_position);
	vec3 direction = reflect(viewDirection, normalize(world_normal));
	
	// Convert the direction vector to spherical coordinates
    float theta = asin(direction.y); // Latitude
    float phi = atan(direction.z, direction.x); // Longitude
    
    // Convert spherical coordinates to texture coordinates
    float u = (phi + PI) / (2.0 * PI);
    float v = (theta + PI / 2.0) / PI;
    
    // Sample the texture using the calculated coordinates
    vec4 color = texture(environment, vec2(u, v));
    
    // Output the color
    ALBEDO = color.rgb;
}