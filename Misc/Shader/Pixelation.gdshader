shader_type canvas_item;

uniform float pixelation : hint_range(0, 0.2);

//uniform float size_x = pixelation;
//uniform float size_y = pixelation;

void fragment() {
	//vec2 pixelNumber = vec2(textureSize(TEXTURE, 0)) * pixelation;
	//vec2 pixelatedUV = round(UV * pixelNumber) / pixelNumber;
	//COLOR = texture(TEXTURE, pixelatedUV);
	
	vec2 uv = SCREEN_UV;
	uv -= mod(uv, vec2(pixelation, pixelation));
	
	COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 1.0).rgb;

}



