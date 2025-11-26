shader_type spatial;

uniform vec4 base_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 1.0, 1.0);

uniform float light_strength = 0.0;
uniform float shadow_strength = 1.0;
uniform float precision = 0.5;

uniform vec4 world_gradient_color_start : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 world_gradient_color_end : source_color = vec4(0.0, 0.0, 1.0, 1.0);
uniform bool horizontal = true;
uniform float offset : hint_range(0.0, 2.0) = 1.0;
uniform float gradient_strength = 0.0;
uniform vec2 y_min_max = vec2(0.0);
uniform vec2 x_min_max = vec2(0.0);

uniform sampler2D albedo_texture : hint_screen_texture;


void fragment() {
	vec4 c = texture(albedo_texture, UV);
	float line = ceil((c.r + c.g + c.b - precision) / 3.0);
	vec4 new_base = mix(base_color, light_color, light_strength);
	vec3 new = mix(new_base.rgb, shadow_color.rgb, c.r * shadow_strength);
	new = mix(vec3(0.0, 0.0, 0.0), new, line);
	//ALPHA = c.a;
	ALBEDO = c.rgb;
}
