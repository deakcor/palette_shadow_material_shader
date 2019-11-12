shader_type spatial;
render_mode cull_disabled;

uniform sampler2D palette;
uniform sampler2D tex;
uniform float step: hint_range(0.0,1.0);

vec4 find_color(vec4 texcolor,int p){
	int pos=0;
	bool stop=false;
	int bpos=0;
	float bdiff=1.0;
	while (pos<textureSize(palette,0).x && !stop){
		vec4 acolorpalette=texelFetch(palette,ivec2(pos,0), 0);
		if (acolorpalette.a==0.0){
			stop=true;
		}else{
		vec3 colorpalette=acolorpalette.rgb;
		vec3 diff=(colorpalette-texcolor.rgb);
		float truediff=max(max(abs(diff.x), abs(diff.y)), abs(diff.z));
		if (truediff<bdiff){
			bpos=pos;
			bdiff=truediff;
		}

		pos+=1;
		}
	}
	texcolor=texelFetch(palette,ivec2(bpos,p), 0);
	return texcolor;
}

void fragment()
{
	ALBEDO=vec3(0.0);
	//ALBEDO=texture(tex,UV).rgb;
}

void light(){
	float intensity;
	vec4 color;
	float shadow=0.4;
	intensity = dot(LIGHT,NORMAL);

	if (intensity > step)
		color = find_color(texture(tex,UV),0);
	else
		color = find_color(texture(tex,UV),1);
	DIFFUSE_LIGHT = color.rgb*LIGHT_COLOR;

	
}