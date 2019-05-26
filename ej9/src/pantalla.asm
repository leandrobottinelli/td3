
GLOBAL MOSTRAR_PANTALLA
EXTERN _NUMERO_TOTAL
EXTERN _BUFFER_NUMERO_PANTALLA

section .rutinas
USE32

BUFFER_VIDEO equ 0xb8000
COLUMNAS equ 0x500


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

      PARTE_ALTA:
      mov eax, [_NUMERO_TOTAL + 0x4]
      jmp BUFFER

      PARTE_BAJA:
      mov eax, [_NUMERO_TOTAL]
      mov dx, 0x01
      ;inc ecx ;me esta agregando espacio

 



      BUFFER:
      rol eax,0x4
      mov bl,0xF
      and ebx,eax

      L_0:
      cmp bl, 0x0
      mov bh, ASCII_TECLA_0 ; 
      jz GUARDADO_LETRA

      L_1:
        cmp bl, 0x1
        mov bh, ASCII_TECLA_1 ;  ; 
        jz GUARDADO_LETRA

      L_2:
        cmp bl, 0x2 ; 
        mov bh, ASCII_TECLA_2 ; 
        jz GUARDADO_LETRA

      L_3:
        cmp bl, 0x3 ; 
        mov bh, ASCII_TECLA_3
        jz GUARDADO_LETRA   

      L_4:
        cmp bl, 0x4
        mov bh, ASCII_TECLA_4 ; 
        jz GUARDADO_LETRA 

      L_5:
        cmp bl, 0x5 ; 
        mov bh, ASCII_TECLA_5
        jz GUARDADO_LETRA   

      L_6:
        cmp bl, 0x6
        mov bh, ASCII_TECLA_6 ; 
        jz GUARDADO_LETRA   

      L_7:
        cmp bl, 0x7 ; 
        mov bh, ASCII_TECLA_7
        jz GUARDADO_LETRA     
      
      L_8:
        cmp bl, 0x8
        mov bh, ASCII_TECLA_8 ; 
        jz GUARDADO_LETRA
      
      L_9:
        cmp bl, 0x9 
        mov bh, ASCII_TECLA_9 
        jz GUARDADO_LETRA  
      
      L_A:
        cmp bl, 0xA 
        mov bh, ASCII_TECLA_A
        jz GUARDADO_LETRA
      
      L_B:
        cmp bl, 0xB 
        mov bh, ASCII_TECLA_B 
        jz GUARDADO_LETRA  
      
      L_C:
        cmp bl, 0xC ; 
        mov bh, ASCII_TECLA_C
        jz GUARDADO_LETRA 
      
      L_D:
        cmp bl, 0xD 
        mov bh, ASCII_TECLA_D
        jz GUARDADO_LETRA 
      
      L_E:
        cmp bl, 0xE 
        mov bh, ASCII_TECLA_E
        jz GUARDADO_LETRA 

      L_F:
        cmp bl, 0xF 
        mov bh, ASCII_TECLA_F
        jz GUARDADO_LETRA 

      ret

      GUARDADO_LETRA:
 
   


      cmp dx,0x1
      jz AA
      jmp BB



      AA:
      cmp ecx, 0x10
      jz MOSTRAR_NUMERO
      jmp CC

      BB:
      cmp ecx, 0x8
      jz PARTE_BAJA

      CC:
      mov byte[_BUFFER_NUMERO_PANTALLA + ecx],bh
      inc ecx
      jmp BUFFER 

      MOSTRAR_NUMERO:
      
      mov ecx, 0x0

      mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS], ASCII_TECLA_0
      mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x01], 0x07
      mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x02], ASCII_TECLA_x
      mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x03], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x04], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x05], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x06], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x07], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x08], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x09], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x0A], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x0B], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x0C], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x0D], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x0E], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x0F], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x10], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x11], 0x07
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x12], ASCII_TECLA_0
      ;mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x13], 0x07

      NUMERO:
      mov al , [_BUFFER_NUMERO_PANTALLA + ecx]  
      mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x04 +ecx*2], al  
      mov byte[BUFFER_VIDEO + 0x50 + COLUMNAS + 0x04 + ecx *2+ 0x01], 0x07
      cmp ecx,0x10
      jz FIN
      inc ecx
      jmp NUMERO

      FIN:
      ret
