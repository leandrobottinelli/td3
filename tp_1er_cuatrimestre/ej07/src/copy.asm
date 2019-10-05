GLOBAL COPY_INIT
GLOBAL COPY_CICLO


section .copy
USE32

COPY_INIT:

    mov ebp, esp  
    mov ecx,[ebp + 4]   ; Tomo los siguientes 3 datos de la pila
    mov edi,[ebp + 8]          
    mov esi,[ebp + 12]         

COPY_CICLO:
    
    mov al, [esi]       
    mov [edi], al       ; Copio en la direccion destino, lo que hay en origen
    inc esi             ; Muevo el puntero de fuente 1 pocision
    inc edi             ; Muevo el puntero de destino 1 pocision
    dec ecx
    jne COPY_CICLO      ; Verifica el flag de 0 del ecx
    xchg bx,bx

    ret


