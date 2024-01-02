shader_type spatial;
render_mode depth_draw_always, cull_disabled, unshaded;

uniform float alpha_clip: hint_range(0, 1) = 0.5;
uniform float depth_edge_buffer = 100.0;
uniform float depth_max = 600.0;
uniform float dither_limit_min = 0.0;
uniform float dither_time_coord_multiplier = 1.0;
uniform float sprite_animation_hframes = 1.0;
uniform float sprite_animation_vframes = 1.0;
uniform float sprite_animation_frame = 0.0;
uniform float sprite_flip_h = 1.0;
uniform vec4 sprite_modulate = vec4(1.0);
uniform vec4 sprite_texture_region = vec4(0.0, 0.0, 1.0, 1.0);
uniform sampler2D sprite_texture_sampler: hint_albedo;

const mat4 dither = mat4(
	vec4(0.0625, 0.5625, 0.1875,  0.6875),
	vec4(0.8125, 0.3125, 0.9375,  0.4375),
	vec4(0.25, 0.75, 0.125, 0.625),
	vec4(1.0, 0.5, 0.875,  0.375)
);

float get_dither_value(int x, int y) {
	float res = 0.0;
	vec4 temp;
	if (x == 0) {temp = dither[0];} 
	else if (x == 1) temp = dither[1];
	else if (x == 2) temp = dither[2];
	else if (x == 3) temp = dither[3];
	
	if (y == 0) {res = temp[0];} 
	else if (y == 1) res = temp[1];
	else if (y == 2) res = temp[2];
	else if (y == 3) res = temp[3];
	
	return res;
}

void fragment() {
	vec2 uv_region = vec2(
		UV.x * sprite_texture_region[2] + sprite_texture_region[0],
		UV.y * sprite_texture_region[3] + sprite_texture_region[1]
	);
	
	float vframe_offset = floor(sprite_animation_frame / sprite_animation_hframes);
	float hframe_offset = sprite_animation_frame - (vframe_offset * sprite_animation_hframes);
	float frame_width = 1.0 / sprite_animation_hframes;
	float frame_height = 1.0 / sprite_animation_vframes;
	vec2 sprite_uv = vec2(uv_region.x * sprite_flip_h + (abs(sprite_flip_h - 1.0) / 2.0), uv_region.y) *
		vec2(frame_width, frame_height) +
		vec2(frame_width * hframe_offset, frame_height * vframe_offset);
	
	vec4 sprite_texture = texture(
		sprite_texture_sampler,
		sprite_uv
	);
	vec4 color = vec4(
		vec3(sprite_texture.rgb * sprite_modulate.rgb),
		sprite_texture.a * sprite_modulate.a
	);
	
	float dither_time_coord = TIME * 60.0 * dither_time_coord_multiplier;
	float dither_limit = max(dither_limit_min, get_dither_value(int(FRAGCOORD.x + dither_time_coord) % 4, int(FRAGCOORD.y + dither_time_coord * 6.0) % 4));
	if (color.a < dither_limit || color.a < alpha_clip) {
		discard;
	}
	ALBEDO = color.rgb;
}