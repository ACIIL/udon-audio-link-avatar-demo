Shader "grappassAudioAvatar"
{
    Properties
    {
    }

    SubShader
    {
        Tags { "RenderType"="Geometry" "Queue"="Geometry"}

        Pass
        {
            Tags 
            {
                "LightMode"="ForwardBase"
            }
            Cull Off
            ZWrite On
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            SamplerState sampler_AudioGraph_Point_Repeat;
            Texture2D<float4> _AudioTexture;
            //uniform float4 _AudioTexture_TexelSize;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                half testw,testh;
                testw = testh = 0.;
                _AudioTexture.GetDimensions(testw, testh);
                fixed4 audioData = _AudioTexture.Sample(sampler_AudioGraph_Point_Repeat, i.uv);
                float4 col = float4(0,.1,0,1);
                //if (true)
                //if (col.r == pow(0.5, 2.2))                
                //if (_AudioTexture_TexelSize.z > 16)
                if (testw > 16)
                {
                    col.rgb = audioData;
                }
                return col;
            }
            ENDCG
        }
    }
}