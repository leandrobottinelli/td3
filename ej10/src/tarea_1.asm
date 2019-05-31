GLOBAL SUMA_TABLA_DIGITOS
EXTERN _NUMERO_TOTAL

EXTERN _ENTRADA_TABLA
EXTERN __INICIO_RAM_TABLA_DIGITOS




;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------
section .text_tarea_1
USE32

SUMA_TABLA_DIGITOS:

    mov eax, 0x00
    mov edx, __INICIO_RAM_TABLA_DIGITOS + 0x10  ; Comienzo desde lel primero numero de la tabla
    mov [_NUMERO_TOTAL], eax                    ; Pongo en cero la parte baja de la suma total
    mov [_NUMERO_TOTAL + 0x04], eax             ; Pongo en cero la parte alta de la suma total


    LP:
    cmp edx, [_ENTRADA_TABLA]                   ; Chequeo si el puntero es siguiente numero de la tabla a cargar 
    jz RESULTADO                                ; Dejo de sumar y vuelvo
    mov eax,[edx]                            
    add [_NUMERO_TOTAL], eax                    ; Sumo la parte baja del numero nuevo al total
    mov eax,[edx+0x04]                          ; Copio la parte alta del numero nuevo
    jc CARRY                                    ; Si la suma de la parte baja tiene carry lo sumo en la parte alta
    jmp N_CARRY   



    CARRY: 
    add byte[_NUMERO_TOTAL+0x04], 0x01          ; Caso de carry en la parte baja, lo sumo a la parte alta



    N_CARRY:
    add [_NUMERO_TOTAL+0x04], eax               ; Sumo la parte alta del numero nuevo al total
    add edx , 0x10                              ; Corro el puntero al siguiente numero de la tabla

    jmp LP

    RESULTADO:
    ret

;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .data_tarea_1
USE32







;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .bss_tarea_1 nobits
USE32
;_NUMERO_TOTAL: resq 2






;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////