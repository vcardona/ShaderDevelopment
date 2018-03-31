// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ShaderDev/BareBone"
{
    //Las propiedades nos permiten crear variables que se visualizan en el inspector para ser manipuladas
    //por los usuarios.
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
    }

    //El subshader nos permite usar diferentes propiedades de un Hardware en especifico.
    Subshader
    {
    
        Pass
        {
        
            CGPROGRAM
            #pragma vertex vert 
            //Estas son directivas de compilador, la segunda es un comando y la tercera un argumento
            //El argumento es el nombre de la función que se va a crear para que realice una tarea especifica
            #pragma fragment frag 
            //Los atributos del mesh como la posición, la normal y el color.
            
            uniform half4 _Color;
            //uniform es una palabra clave para definir variables globales
            //lo que quiere decir es que esta variable es accesible para todas las funciones de este código.
            
            
            struct vertexInput
            {
            
                float4 vertex : POSITION;
            
            };//No podemos olvidar el ; si no lo hacemos se genera un error que en muchos casos es dificil identificar
            
            
            struct vertexOutput
            {
            
                float4 pos : SV_POSITION;
                //No se usa vertex de nuevo, en lugar de esto usamos pos, porque cuando se hace el output del vertex
                //para el fragment shader este es un valor de interpolación, este no es más un vertex position 
                //ahora es la posición de un fragment en particular
            };
            
            //La entrada para este vertex shader es el argumento, en este caso u VertexInput
            //Debe existir una salida para el vertex shader, que en este caso es el struct vertexOutput.
            vertexOutput vert(vertexInput v)
            {
            //Necesitamos que se de un valor al realizar la operación de la función.
            //en este caso lo hacemos por medio de o
            //usamos mul para multiplicar, el primer argumento es Model View Projection matrix.
            //el segundo argumento es la posición del vertex.
            //con esto queda listo nuestro Vertex Shader.
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            //La salida del vertexShader es la entrada del Fragment Shader, por eso en este caso
            //el argumento de frag es el vertexOutput.
            //La Salida del fragmentShader es COLOR. Esta salida va ser 4, por eso se define la variable half4
            //Se pueden seleccionar 3 tipos de datos, fixed, float, half, en este caso se selecciona half4
            //Se debe especificar que va ser half4, en este caso es COLOR, pero puede ser una position
            half4 frag(vertexOutput i) : COLOR
            {
                return _Color;
                //Acá simplement se retorna el color que definimos en Properties
                //Pero para poder usar las propiedades, debemos definirlas, para eso
                //creamos uniform half4 _Color
            }
            
            
            ENDCG
        
       
        }
    
    
    
    }


}