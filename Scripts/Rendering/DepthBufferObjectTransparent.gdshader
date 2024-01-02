shader_type spatial;
render_mode cull_disabled, unshaded;

uniform float depth_edge_buffer = 100.0;
uniform float depth_max = 600.0;
uniform float sprite_animation_hframes = 1.0;
uniform float sprite_animation_vframes = 1.0;
uniform float sprite_animation_frame = 0.0;
uniform float sprite_flip_h = 1.0;
uniform vec4 sprite_modulate = vec4(1.0);
uniform vec4 sprite_texture_region = vec4(0.0, 0.0, 1.0, 1.0);
uniform sampler2D sprite_texture_sampler: hint_albedo;

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
	
	ALBEDO = color.rgb;
	ALPHA = color.a;
}