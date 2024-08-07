shader_type canvas_item;

uniform float progress : hint_range(0, 1);

void fragment () {
	COLOR = texture(TEXTURE, UV);
	
	COLOR.a = progress;
}