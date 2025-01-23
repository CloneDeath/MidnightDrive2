shader_type spatial;
// Prevent the quad from being affected by lighting and fog. This also improves performance.
render_mode unshaded, fog_disabled;

void vertex() {
  POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

uniform vec2 resolution = vec2(10, 10);
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec2 sample = floor(SCREEN_UV * resolution + vec2(0.5, 0.5)) / resolution;
	ALBEDO.rgb = textureLod(screen_texture, sample, 0.0).rgb;
}