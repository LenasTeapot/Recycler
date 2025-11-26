shader_type canvas_item;

uniform vec4 gradient_start : source_color  = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 gradient_end : source_color  = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool horizontal = true;
uniform float offset : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	float dir = mix(UV.r, UV.g, float(horizontal));
	vec4 mix_col = mix(gradient_start, gradient_end, smoothstep(dir + offset, dir, offset));
	COLOR = mix(gradient_end, mix_col, step(dir, offset));
}
