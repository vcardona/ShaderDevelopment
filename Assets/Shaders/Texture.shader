Shader "ShaderDev/01Texture"
{
  
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex("Main Texture", 2D) = "white" {}
    }

    Subshader
    {
    
        Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent"}
        Pass
        {
        
           // Blend ScrAlpha OneMinusSrcAlpha
        
            CGPROGRAM
            
            #pragma vertex vert 
            #pragma fragment frag 
  
            
            uniform half4 _Color;
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            
            struct vertexInput
            {
            
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            
            };
            
            
            struct vertexOutput
            {
            
                float4 pos : SV_POSITION;
                float4 texcoord : TEXCOORD0;
                
            };
            
            
            vertexOutput vert(vertexInput v)
            {
            
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = (v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw);
                return o;
            }
            
            
            half4 frag(vertexOutput i) : COLOR
            {
                return tex2D ( _MainTex,i.texcoord) * _Color;
                
            }
            
            
            ENDCG
        
       
        }
    
    
    
    }


}