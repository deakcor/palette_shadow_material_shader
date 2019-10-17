shader_type spatial;
uniform vec4 color1:hint_color;
uniform vec4 color2:hint_color;
uniform vec4 color3:hint_color;
uniform vec2 range;
void fragment()
{
	ALBEDO=vec3(0.0);

}

void light(){
	float intensity;
	vec4 color;
	intensity = dot(LIGHT,NORMAL);

	if (intensity > range.x)
		color = color1;
	else if (intensity > range.y)
		color = color2;
	else
		color = color3;
	DIFFUSE_LIGHT = color.rgb;

	
}