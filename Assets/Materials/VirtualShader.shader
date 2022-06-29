 Shader "Custom/ClipBoxVirtual" {
     Properties {
         _MainTex ("Albedo (RGB)", 2D) = "white" {}
         _Glossiness ("Smoothness", Range(0,1)) = 0.5
         _Metallic ("Metallic", Range(0,1)) = 0.0
     }
 
     SubShader {
         Tags { "RenderType"="Opaque" }
         LOD 200
 
         CGPROGRAM
         #pragma surface surf Standard fullforwardshadows addshadow
         #pragma target 3.0
 
         sampler2D _MainTex;
         half _Glossiness;
         half _Metallic;
         float4x4 _WorldToBoxVirtual;
 
         struct Input {
             float2 uv_MainTex;
             float3 worldPos;
         };
 
         void surf (Input IN, inout SurfaceOutputStandard o) {
             float3 boxPosition = mul(_WorldToBoxVirtual, float4(IN.worldPos, 1));
             clip(boxPosition + 0.5);
             clip(0.5 - boxPosition);
 
            //  fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //  o.Albedo = c.rgb;
             o.Albedo = fixed3(0.8, 0.6, 0.4);
            //  o.Albedo = fixed3(1, 1, 1);
             o.Metallic = _Metallic;
             o.Smoothness = _Glossiness;
            //  o.Alpha = c.a;
         }
         ENDCG
     }
     FallBack "Diffuse"
 }
