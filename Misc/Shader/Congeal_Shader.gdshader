shader_type canvas_item;

uniform sampler2D NOISE_PATTERN;
uniform vec2 scroll = vec2(-0.08, 0.08);
uniform vec2 noiseScale = vec2(1,1);
//uniform vec4 flash_color : hint_color = vec4(1.0);
uniform float flash_modifier : hint_range(0.0, 1.0) = 0.0;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float sine = sin(rotation);
    float cosine = cos(rotation);
    
    uv -= pivot;
    uv.x = uv.x * cosine - uv.y * sine;
    uv.y = uv.x * sine + uv.y * cosine;
    uv += pivot;

    return uv;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float tex_alpha = texture(TEXTURE, UV).a;
	float pattern_intensity = texture(NOISE_PATTERN, rotateUV(UV, vec2(.5), .58) + noiseScale + TIME * -scroll/3.0).y;
	float intensity = tex_alpha * pattern_intensity;
	COLOR = vec4(intensity);
	COLOR.rgb = mix(color.rgb, vec4(intensity).rgb, flash_modifier);
	COLOR.b = 1.1;
	COLOR.g = 1.05;
	//COLOR.r = 2.0;
	}
	
	