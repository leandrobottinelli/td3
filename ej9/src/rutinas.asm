GLOBAL CARGAR_TABLA
GLOBAL CARGAR_TABLA_2
GLOBAL SUMA_TABLA_DIGITOS

EXTERN _CONTADOR_TECLAS
EXTERN _ENTRADA_TABLA
EXTERN _CONTADOR_TECLAS_BYTES
EXTERN __INICIO_RAM_TABLA_DIGITOS
EXTERN _flag_16_TECLAS
EXTERN _NUMERO_TOTAL




section .rutinas
USE32


;-----------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------

CARGAR_TABLA:

    mov ebp, esp  
    mov al, [ebp + 4]						    ;Recibo por la pila, el valor de la tecla
    mov ecx, [_CONTADOR_TECLAS]     		    ;Cargo valor del contador,ultima pocision de tecla guardada
    mov [__INICIO_RAM_TABLA_DIGITOS + ecx], al  ;Guardo la tecla en el vector
                                   				; de la tabla, indicada por el contador
    inc ecx
    cmp ecx, 0x10		                        ;Comparo si llego a 16 bytes
    jz RESET_CONTADOR
    jmp INCREMENTO_CONTADOR


    RESET_CONTADOR:
    mov bx, 0x01			
    mov [_flag_16_TECLAS], bx	;Activo el flag de que supero las 16 teclas

    mov ecx, 0x0				;Reinicio contador a 0, para poder seguir
    							;guardando en el mismo vector

    INCREMENTO_CONTADOR:
    mov [_CONTADOR_TECLAS], ecx     ;Guardo el valor del contador incrementado
    ret                            ;para apuntar al siguiente digito de la tabla

;-----------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------


CARGAR_TABLA_2:

	mov ecx, [_flag_16_TECLAS]
    cmp ecx, 0x01				;Chequeo si hay 16 teclas y el contador di
    jz TECLAS_16 				;la vuelta, ultimo bit paso 0xF

    mov ecx,[_CONTADOR_TECLAS]	; Si hay menos de 16, cargo la cantidad de teclas
    jmp CEROS 					

    
   	TECLAS_16:			         
	mov bx, 0x0					 ;Reseteo el flag de la funcion CARGAR_TABLA
	mov [_flag_16_TECLAS], bx	 ;que me indica que hubo mas de 16 teclas.
    mov ecx, 0x10				 ;Cargo que la cantidad de teclas son 16
    shr ecx, 0x1                 ;Divido por 2, porque voy a juntar de a 2 hexas en 1 byte
    mov edx, [_CONTADOR_TECLAS_BYTES] ;Cargo la pocision de la entrada de la tabla
    jmp GUARDADO_NUMERO




	CEROS:				;Completo las pocisiones de las teclas faltantes a 16 con 0				
	mov al, 0x00			
	mov [__INICIO_RAM_TABLA_DIGITOS + ecx], al             

  inc ecx
	cmp ecx, 0x10 		;Chequeo si llegue a la tecla numero 16
	jz PARIDAD
	jmp CEROS
    
	

	PARIDAD:    
	mov ecx,[_CONTADOR_TECLAS] 
   	test ecx,1  				; Compruebo si el numero de teclas ingresadas
   	jnz IMPAR       			; son pares o impares
   	jmp PAR
   	

   	IMPAR:
   	mov edx, [_CONTADOR_TECLAS_BYTES]
   	inc edx

   	mov al,[__INICIO_RAM_TABLA_DIGITOS] ;Cargo la tecla mas significativa
   	mov ebx,[_ENTRADA_TABLA] 
   	inc ecx  					;Lo hago PAR redondeando para arriba 
	shr ecx, 0x1 				;Divido por 2, porque voy a juntar de a 2 hexas en 1 byte

    mov [ebx + ecx - 0x1], al	;Guardo en la primera pocision, la primer tecla
    dec ecx						;que tiene cargada la letra y un cero.
   	jmp GUARDADO_NUMERO



   	PAR:
   	mov edx, [_CONTADOR_TECLAS_BYTES]
    shr ecx, 0x1 ;Divido por 2, porque voy a juntar de a 2 hexas en 1 byte


	GUARDADO_NUMERO: 

   	mov al,[__INICIO_RAM_TABLA_DIGITOS + edx] ;Recorro las tecla y la siguiente
   	mov bl,[__INICIO_RAM_TABLA_DIGITOS + edx + 0x1]
   	add edx, 0x2 ;En el siguiente ciclo, agarro las 2 siguientes
   	mov [_CONTADOR_TECLAS_BYTES], edx 



   	shl al, 0x4  				;Desplazo el primer byte 4 pocisiones
   	or al, bl	 				;y sumo el hexa de la primera tecla y la segunda

   	mov ebx,[_ENTRADA_TABLA]    ;Cargo el valor de que entrada de la Tabla estoy
    mov [ebx + ecx - 0x1], al 	;Guardo el byte de las dos teclas
    dec ecx
    jne GUARDADO_NUMERO ;Repito hasta que el contador de cantidad de teclas llegue a cero
    jmp RESET_CONTADOR_2


    RESET_CONTADOR_2:
    add ecx, 0x10  
    mov edx, 0x00  
    mov [_CONTADOR_TECLAS_BYTES], edx ; Reseteo el contador que barre las teclas de a dos
    mov [_CONTADOR_TECLAS], edx 	  ; Reseteo el contador con la cantidad de teclas
    add [_ENTRADA_TABLA], ecx         ; Guardo el valor del contador incrementado
    ret                               ; para apuntar a la siguiente entrada de la tabla
;----------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------


section .tarea_1

SUMA_TABLA_DIGITOS:

    mov eax, 0x00
    mov edx, __INICIO_RAM_TABLA_DIGITOS + 0x10
    mov [_NUMERO_TOTAL], eax
    mov [_NUMERO_TOTAL + 0x04], eax

    ;xchg bx, bx


    LP:
    cmp edx, [_ENTRADA_TABLA]
    jz RESULTADO
    mov eax,[edx]
    add [_NUMERO_TOTAL], eax
    mov eax,[edx+0x04]
    jc CARRY
    jmp LP2   



    CARRY: 
    add byte[_NUMERO_TOTAL+0x04], 0x01



    LP2:
    add [_NUMERO_TOTAL+0x04], eax
    add edx , 0x10

    jmp LP

    RESULTADO:


    ret
