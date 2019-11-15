shader_type spatial;
render_mode cull_disabled;

//for texture
uniform sampler2D palette;
uniform sampler2D tex;
//if no texture
uniform vec4 color_light:hint_color;
uniform vec4 color_shadow:hint_color;
//spec
uniform vec4 specular_color:hint_color;
uniform float glow_reduction=32;
//rim
uniform float rim_amount: hint_range(0.0,1.0);
//amount of shadow
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
	
	ALBEDO=color_light.rgb;
	//ALBEDO=texture(tex,UV).rgb;
}

void light(){
	
	float intensity;
	vec4 color;
	float shadow=0.4;
	intensity = dot(LIGHT,NORMAL);
	
	//color
	if (intensity > step)
		
		if (color_light.a==0.0){
			color = find_color(texture(tex,UV),0);
		}else{
			color = color_light;
		}
		
	else
		if (color_shadow.a==0.0){
			color = find_color(texture(tex,UV),1);
		}else{
			color = color_shadow;
		}
		
		
		
	//specular
	vec3 halfVector = normalize(LIGHT + VIEW);
	float NdotH = dot(NORMAL, halfVector);
	float specularIntensity = pow(NdotH * 1.0, glow_reduction*glow_reduction);
	float specularIntensitySmooth = smoothstep(0.005, 0.01, specularIntensity);
	vec4 specular = specularIntensitySmooth * specular_color;
	
	// Calculate rim lighting.
	float rimDot = 1.0 - dot(VIEW, NORMAL);
	float rimIntensity = rimDot * pow(intensity, 0.1);
	rimIntensity = smoothstep(rim_amount - 0.01, rim_amount + 0.01, rimIntensity);
	vec4 rim = rimIntensity * specular_color;
	
	DIFFUSE_LIGHT = (rim.rgb+color.rgb+specular.rgb)*LIGHT_COLOR;
	
	
}