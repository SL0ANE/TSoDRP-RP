#version 110

uniform sampler2D DiffuseSampler;

varying vec2 texCoord;
varying vec2 oneTexel;

void main(){
    vec4 center = texture2D(DiffuseSampler, texCoord);
    vec4 left = texture2D(DiffuseSampler, texCoord - vec2(oneTexel.x * 2.0, 0.0));
    vec4 right = texture2D(DiffuseSampler, texCoord + vec2(oneTexel.x * 2.0, 0.0));
    vec4 up = texture2D(DiffuseSampler, texCoord - vec2(0.0, oneTexel.y * 2.0));
    vec4 down = texture2D(DiffuseSampler, texCoord + vec2(0.0, oneTexel.y * 2.0));
    float leftDiff  = abs(center.a - left.a);
    float rightDiff = abs(center.a - right.a);
    float upDiff    = abs(center.a - up.a);
    float downDiff  = abs(center.a - down.a);
    float total = 0.0;
    if(center.a == 1.0 && left.a == 0.0) total = 1.0;
    if(center.a == 1.0 && right.a == 0.0) total = 1.0;
    if(center.a == 1.0 && up.a == 0.0) total = 1.0;
    if(center.a == 1.0 && down.a == 0.0) total = 1.0;
    vec3 outColor = center.rgb * center.a + left.rgb * left.a + right.rgb * right.a + up.rgb * up.a + down.rgb * down.a;
    gl_FragColor = vec4(center.rgb, total);
}
