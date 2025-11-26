shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear;
uniform vec4 gradient_start : source_color  = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 gradient_end : source_color  = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool horizontal = true;
uniform float offset : hint_range(0.0, 2.0) = 1.0;

void fragment() {
	vec4 col = texture(screen_texture, SCREEN_UV);
	float dir = mix(UV.r, UV.g, float(horizontal));
	vec4 mix_col = mix(gradient_start, gradient_end, smoothstep(dir + offset, dir, offset));
	COLOR = mix(col * mix_col, col * mix_col, step(dir, offset));
}

