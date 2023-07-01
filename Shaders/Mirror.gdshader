shader_type spatial;
render_mode unshaded;
uniform sampler2D mirrorTexture;

void fragment() {
	vec4 tex = texture(mirrorTexture, SCREEN_UV);
	ALBEDO = vec3(tex.xyz);
	ALBEDO.rgb = mix(pow((ALBEDO.rgb + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),ALBEDO.rgb.rgb * (1.0 / 12.92),lessThan(ALBEDO.rgb,vec3(0.04045)));
}
