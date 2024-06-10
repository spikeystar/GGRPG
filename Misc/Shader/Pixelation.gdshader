shader_type canvas_item;

uniform float pixelation : hint_range(0, 0.2);

void fragment() {
	vec2 pixelNumber = vec2(textureSize(TEXTURE, 0)) * pixelation;
	vec2 pixelatedUV = round(UV * pixelNumber) / pixelNumber;
	COLOR = texture(TEXTURE, pixelatedUV);

}



