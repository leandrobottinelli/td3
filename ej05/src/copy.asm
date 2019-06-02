GLOBAL COPY_INIT
GLOBAL COPY_CICLO


section .copy
USE32
; Este copy ya esta en ROM. la podes usar directamente
COPY_INIT:

    mov ebp, esp  
    mov ecx,[ebp + 4]
    mov edi,[ebp + 8]
    mov esi,[ebp + 12]

COPY_CICLO:
    
    mov al, [esi]  ;copio 1 byte 
    mov [edi], al  ;
    inc esi        ;muevo el puntero de fuente 
    inc edi        ;muevo el puntero de destino
    dec ecx
    jne COPY_CICLO   ;verifica el flag de 0 del ecx
    xchg bx,bx

    ret


