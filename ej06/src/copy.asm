GLOBAL COPY_INIT
GLOBAL COPY_CICLO


section .copy
USE32

COPY_INIT:

    mov ebp, esp  
    mov ecx,[ebp + 4]
    mov edi,[ebp + 8]
    mov esi,[ebp + 12]

COPY_CICLO:
    
    mov al, [esi]     ; Copio 1 byte  de la direccion de origen
    mov [edi], al     ; Copio el byte a la direccion de destino
    inc esi           ; Muevo el puntero de fuente 
    inc edi           ; Muevo el puntero de destino
    dec ecx
    jne COPY_CICLO    ; Verifica el flag de 0 del ecx

    ret


