shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 1.0, 1.0);

uniform float light_strength : hint_range(0.0, 1.0)  = 0.0;
uniform float shadow_strength : hint_range(0.0, 1.0)  = 1.0;
uniform float precision = 0.5;

uniform vec4 world_gradient_color_start : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 world_gradient_color_end : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool horizontal = true;
uniform float offset = 3000.0;
uniform float gradient_strength : hint_range(0.0, 1.0) = 0.5;
varying vec2 world_pos;

void vertex() {
        world_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
    }
	
//TODO: This only works below y = 0
vec3 world_gradient(vec3 color_in) {
	float dir = mix(world_pos.r, world_pos.g, float(horizontal));
	vec4 mix_col = mix(world_gradient_color_start, world_gradient_color_end, smoothstep(dir + offset, dir, offset));
	vec4 new_color = mix(world_gradient_color_end, mix_col, step(dir, offset));
	return mix(color_in, new_color.rgb * color_in, gradient_strength);
	//return new_color.rgb;
}


void fragment() {
	// Capture texture
	vec4 c = texture(TEXTURE, UV);
	// TODO : Remove lines and move to another sprite sheet
	float line = ceil((c.r + c.g + c.b - precision) / 3.0);
	// Lerp from base to light color
	vec4 new_base = mix(base_color, light_color, light_strength);
	// Lerp from new result to shadow color based on map and strength
	vec3 new = mix(new_base.rgb, shadow_color.rgb, c.r * shadow_strength);
	// TODO : A Step might be a better solution, if lines are kept in this texture
	new = world_gradient(mix(vec3(0.0, 0.0, 0.0), new, line));
	// Use original alpha and new colors
	COLOR = vec4(new.r, new.g, new.b, c.a);
}
