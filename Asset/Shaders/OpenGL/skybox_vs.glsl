#version 400
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

struct Light
{
    int lightType;
    float lightIntensity;
    uint lightCastShadow;
    int lightShadowMapIndex;
    int lightAngleAttenCurveType;
    int lightDistAttenCurveType;
    vec2 lightSize;
    ivec4 lightGUID;
    vec4 lightPosition;
    vec4 lightColor;
    vec4 lightDirection;
    vec4 lightDistAttenCurveParams[2];
    vec4 lightAngleAttenCurveParams[2];
    mat4 lightVP;
    vec4 padding[2];
};

layout(binding = 0, std140) uniform PerFrameConstants
{
    mat4 viewMatrix;
    mat4 projectionMatrix;
    vec4 camPos;
    int numLights;
    Light allLights[100];
} _30;

layout(binding = 1, std140) uniform PerBatchConstants
{
    mat4 modelMatrix;
} _67;

layout(binding = 0) uniform sampler2D diffuseMap;
layout(binding = 1) uniform sampler2DArray shadowMap;
layout(binding = 2) uniform sampler2DArray globalShadowMap;
layout(binding = 3) uniform samplerCubeArray cubeShadowMap;
layout(binding = 4) uniform samplerCubeArray skybox;
layout(binding = 5) uniform sampler2D normalMap;
layout(binding = 6) uniform sampler2D metallicMap;
layout(binding = 7) uniform sampler2D roughnessMap;
layout(binding = 8) uniform sampler2D aoMap;
layout(binding = 9) uniform sampler2D brdfLUT;

out vec3 UVW;
layout(location = 0) in vec3 inputPosition;

void main()
{
    UVW = inputPosition;
    mat4 matrix = _30.viewMatrix;
    matrix[3].x = 0.0;
    matrix[3].y = 0.0;
    matrix[3].z = 0.0;
    vec4 pos = (_30.projectionMatrix * matrix) * vec4(inputPosition, 1.0);
    gl_Position = pos.xyww;
}

