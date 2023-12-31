shader_type spatial;
render_mode depth_draw_always, cull_disabled, unshaded;

uniform float depth_edge_buffer = 100.0;
uniform float depth_max = 600.0;
uniform float sprite_animation_hframes = 1.0;
uniform float sprite_animation_vframes = 1.0;
uniform float sprite_animation_frame = 0.0;
uniform float sprite_flip_h = 1.0;
uniform sampler2D sprite_texture_sampler: hint_albedo;

void fragment() {
	float depth = textureLod(DEPTH_TEXTURE, SCREEN_UV, 0.0).r;
	vec4 upos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, depth * 2.0 - 1.0, 1.0);
	vec3 pixel_position = upos.xyz / upos.w;
	
	float vframe_offset = floor(sprite_animation_frame / sprite_animation_hframes);
	float hframe_offset = sprite_animation_frame - (vframe_offset * sprite_animation_hframes);
	float frame_width = 1.0 / sprite_animation_hframes;
	float frame_height = 1.0 / sprite_animation_vframes;
	vec2 sprite_uv = vec2(UV.x * sprite_flip_h + (abs(sprite_flip_h - 1.0) / 2.0), UV.y) *
		vec2(frame_width, frame_height) +
		vec2(frame_width * hframe_offset, frame_height * vframe_offset);
	
	vec4 sprite_texture = texture(
		sprite_texture_sampler,
		sprite_uv
	);
	ALBEDO = sprite_texture.rgb; // * (1.0 - (pixel_position.z / (depth_max + depth_edge_buffer + depth_edge_buffer)));
	ALPHA = sprite_texture.a;
	ALPHA_SCISSOR = 0.5;
}