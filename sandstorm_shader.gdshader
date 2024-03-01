shader_type fog;

// Create a FogVolume node. Activate volumetric fog in WorldEnviroment
// Create a shader, atach this script, create a noise and a gradient

uniform sampler2D noise_ex : repeat_enable;
uniform sampler2D grad_tex;

uniform float noise_scale = 1.0;
uniform float flatness = 1.0;
uniform float density = 1.0;



void fog(){
    vec2 move_uv = vec2(0.2, 0.0) * TIME;
    float detail_noise = texture(noise_ex, WORLD_POSITION.xz * noise_scale + move_uv * 0.5).r;
    detail_noise *= 0.2;
    float noise = texture(noise_ex, WORLD_POSITION.xz * noise_scale + move_uv).r;
    DENSITY = mix(1.0, noise, UVW.y * flatness);//noise;
    DENSITY *= step(0.0, -SDF) * density;
    vec3 col = texture(grad_tex, vec2(DENSITY, 0.5)).rgb;
    ALBEDO = vec3(col);
}