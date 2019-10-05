
GLOBAL MOSTRAR_PANTALLA
EXTERN _NUMERO_TOTAL
EXTERN _BUFFER_NUMERO_PANTALLA
EXTERN _BUFFER_VIDEO


section .rutinas
USE32

;%define FILAS         0x50
;%define COLUMNAS      0x500

%define ASCII_TECLA_A 0x41
%define ASCII_TECLA_B 0x42
%define ASCII_TECLA_C 0x43
%define ASCII_TECLA_D 0x44
%define ASCII_TECLA_E 0x45
%define ASCII_TECLA_F 0x46
%define ASCII_TECLA_0 0x30
%define ASCII_TECLA_1 0x31
%define ASCII_TECLA_2 0x32
%define ASCII_TECLA_3 0x33
%define ASCII_TECLA_4 0x34
%define ASCII_TECLA_5 0x35
%define ASCII_TECLA_6 0x36
%define ASCII_TECLA_7 0x37
%define ASCII_TECLA_8 0x38
%define ASCII_TECLA_9 0x39
%define ASCII_TECLA_x 0x78



    MOSTRAR_PANTALLA:

      mov ecx, 0x0 
      mov edx, 0x0
      mov ebx, 0x0


      mov ebp, esp  

      PARTE_ALTA:

      mov eax,[ebp + 4]      ; Cargo direccion de __NUMERO_TOTAL
      mov eax, [eax + 0x4]   ; Cargo los 8 digitos mas significativos [_NUMERO_TOTAL + 0x4]   
      jmp BUFFER

      PARTE_BAJA:
      mov eax,[ebp + 4]      ; Cargo direccion de __NUMERO_TOTAL
      mov eax, [eax]         ; Cargo los 8 digitos menos significativos [_NUMERO_TOTAL] 
      mov dx, 0x01           ; Flag para contar las primeras 8 teclas


      BUFFER:
      rol eax,0x4                     ; Voy desplazando el hexa mas significativo ciclo a ciclo
      mov bl,0xF                     
      and ebx,eax                     ; Me quedo solo con el hexa que desplaze en bl, sin alterar eax

      L_0:
        cmp bl, 0x0           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_0 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA

      L_1:      
        cmp bl, 0x1           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_1 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA

      L_2:
        cmp bl, 0x2           ; Comparo el hexa de la tecla con su valor  
        mov bh, ASCII_TECLA_2 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA

      L_3:
        cmp bl, 0x3           ; Comparo el hexa de la tecla con su valor  
        mov bh, ASCII_TECLA_3 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA   

      L_4:
        cmp bl, 0x4           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_4 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA 

      L_5:
        cmp bl, 0x5           ; Comparo el hexa de la tecla con su valor  
        mov bh, ASCII_TECLA_5 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA   

      L_6:
        cmp bl, 0x6           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_6 ; Cargo valor ascii de la tecla  
        jz GUARDADO_LETRA   

      L_7:
        cmp bl, 0x7           ; Comparo el hexa de la tecla con su valor  
        mov bh, ASCII_TECLA_7 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA     
      
      L_8:
        cmp bl, 0x8           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_8 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA
      
      L_9:
        cmp bl, 0x9           ; Comparo el hexa de la tecla con su valor 
        mov bh, ASCII_TECLA_9 ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA  
      
      L_A:
        cmp bl, 0xA           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_A ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA
      
      L_B:
        cmp bl, 0xB           ; Comparo el hexa de la tecla con su valor 
        mov bh, ASCII_TECLA_B ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA  
      
      L_C:
        cmp bl, 0xC           ; Comparo el hexa de la tecla con su valor  
        mov bh, ASCII_TECLA_C ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA 
      
      L_D:
        cmp bl, 0xD           ; Comparo el hexa de la tecla con su valor
        mov bh, ASCII_TECLA_D ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA 
      
      L_E:
        cmp bl, 0xE           ; Comparo el hexa de la tecla con su valor 
        mov bh, ASCII_TECLA_E ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA  

      L_F:
        cmp bl, 0xF           ; Comparo el hexa de la tecla con su valor 
        mov bh, ASCII_TECLA_F ; Cargo valor ascii de la tecla 
        jz GUARDADO_LETRA 

      ret

 
      GUARDADO_LETRA:
 
      cmp dx,0x1            ; Utilizo dx de flag para primero cargar la parte baja y luego la alta
      jz ALTA
      jmp BAJA


      ALTA:
      cmp ecx, 0x10         ; Cuento las siguientes 8 teclas del numero de salida
      jz MOSTRAR_NUMERO
      jmp GUARDADO_BUFFER

      BAJA:
      cmp ecx, 0x8          ; Cuento las primeras 8 teclas del numero de salida
      jz PARTE_BAJA

      GUARDADO_BUFFER:
      mov byte[_BUFFER_NUMERO_PANTALLA + ecx],bh
      inc ecx
      jmp BUFFER 

      MOSTRAR_NUMERO:
      
      mov ecx, 0x0
      mov eax,[ebp + 8]     ; Guardo el valor de FILAS 
      mov ebx,[ebp + 12]    ; Guardo el valor de COLUMNAS 

      add eax, ebx          ; Guardo el valor de FILAS + COLUMNAS para usarlo en el buffer

      mov byte[_BUFFER_VIDEO + eax ], ASCII_TECLA_0
      mov byte[_BUFFER_VIDEO + eax + 0x01], 0x07  
      mov byte[_BUFFER_VIDEO + eax + 0x02], ASCII_TECLA_x
      mov byte[_BUFFER_VIDEO + eax + 0x03], 0x07


      NUMERO:
      mov bl , [_BUFFER_NUMERO_PANTALLA + ecx]                  ; Offset de columnas y filas arbitrario
      mov byte[_BUFFER_VIDEO + eax + 0x04 +ecx*2], bl           ; Guardo cada letra en el buffer de salida
      mov byte[_BUFFER_VIDEO + eax + 0x04 + ecx *2+ 0x01], 0x07 ; Guardo el color de la letra y fondo despues de cada letra
      cmp ecx,0x10                                              ; Cuento hasta 16 digitos y retorno
      jz FIN
      inc ecx
      jmp NUMERO

      FIN:
      ret
