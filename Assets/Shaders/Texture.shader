Shader "ShaderDev/02Texture"
{
  
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex("Main Texture", 2D) = "white" {}
        //Se agrego esta nueva variable para la textura
    }

    Subshader
    {
    
        Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent"}
        Pass
        {
        
           Blend SrcAlpha OneMinusSrcAlpha //En este punto se encontro el error que no permitia la ejecución.
        
            CGPROGRAM
            
            #pragma vertex vert 
            #pragma fragment frag 
  
            
            uniform half4 _Color;
            uniform sampler2D _MainTex;//Siempre que agregamos una propiedad en este caso _MainTex debemos agregar la variable
                                        //en el bloque de código de CG, en este caso agregamos esta variable.
            uniform float4 _MainTex_ST;
            //Esta variable la agregamos para poder hacer el Tiling y el Offset 
            
            struct vertexInput
            {
            
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
                //Leemos un atributo de la malla y lo pasamos al vertex shader, para leer esta propiedad en el VERTEX INPUT.
                //entonces agregamos esta propiedad en el vertexInput, su nombre texcoord para texture coordinate.
                //El numero al final TEXCOORD0 es debido a que puede existir más de un UV set asociado a la malla.
                //podemos leer diferentes UV sets agregando el numero, si vamos hacer esto declaramos otra propiedad,
                // pero al final usamos TEXCOORD1
            };
            
            //Hacemos la segunda modificación en el vertexOutput que es entregado por el rasterizador.
            struct vertexOutput
            {
            
                float4 pos : SV_POSITION;
                float4 texcoord : TEXCOORD0;
                //Usamos el mismo valor que utilizamos en el vertex input para la variable texcoord
            };
            
            
            vertexOutput vert(vertexInput v)
            {
            
                //Acá establecemos una conexión entre el Vertex Shader y el Vertex Output ya que este es el paquete
                // que va al Fragment Shader.
                //Tomamos el valor que se esta leyendo de la malla  y lo asiganmos al valor que va al vertex shader
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                //o.texcoord.xy = v.texcoord;
                o.texcoord.xy = (v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw);
                //Esta línea comentada permite ver en funcionamiento el tiling y el offset
                // X - Y es para el Tiling y z - w para el offset
                return o;
            }
            
            
            half4 frag(vertexOutput i) : COLOR
            {
                // Con esta opción podemos ver la tinta del color en la textura.
                return tex2D ( _MainTex,i.texcoord) * _Color;
                
                
                
                //return _Color;
               // tex2D(_MainTex, i.texcoord);
                
                //De esta forma podemos ver como se cuadra la textura con base en la región geometrica que cubre los pixeles.
                //Pero no se da el blend ademas el color se da de forma general en la textura.
                
            }
            
            
            ENDCG
        
       
        }
    
    
    
    }


}