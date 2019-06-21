GLOBAL TAREA_2
GLOBAL TSS_TAREA_2
GLOBAL _TSS_2_eax
GLOBAL _TSS_2_ebx
GLOBAL _TSS_2_ecx
GLOBAL _TSS_2_edx
GLOBAL _TSS_2_edi
GLOBAL _TSS_2_esi
GLOBAL _TSS_2_ebp
GLOBAL _TSS_2_esp
GLOBAL _TSS_2_eip
GLOBAL _TSS_2_eflags
GLOBAL _TSS_2_cs
GLOBAL _TSS_2_ds
GLOBAL _TSS_2_es
GLOBAL _TSS_2_ss

EXTERN __FIN_PILA_NUCLEO_TAREA_2
EXTERN cs_sel_32
EXTERN ds_sel_32


EXTERN _NUMERO_TOTAL

EXTERN _ENTRADA_TABLA
EXTERN __INICIO_RAM_TABLA_DIGITOS




;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------
section .text_tarea_2
USE32

TAREA_2:

    hlt
    mov eax, 0x03
    jmp TAREA_2

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
    ;mov eax,[_NUMERO_TOTAL]                     
    ;cmp eax, 0x20000000                         ; Comparo contra el numero de 512MB
    ;jge FIN                                     ; Si es mayor o igual finalizo
    ;mov eax,[eax]                               ; Si es menor intento leer esa direccion

    FIN:
    hlt
    jmp TAREA_2

;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .tss_tarea_2
USE32

TSS_TAREA_2:

    _TSS_2_eax:    resw 2 
    _TSS_2_ebx:    resw 2 
    _TSS_2_ecx:    resw 2 
    _TSS_2_edx:    resw 2 
    _TSS_2_edi:    resw 2 
    _TSS_2_esi:    resw 2 
    _TSS_2_ebp:    resw 2 
    _TSS_2_esp:    dd __FIN_PILA_NUCLEO_TAREA_2
    _TSS_2_eip:    dd TAREA_2
    _TSS_2_eflags: dd 0x202
    _TSS_2_cs:     dw cs_sel_32     
    _TSS_2_ds:     dw ds_sel_32
    _TSS_2_es:     dw ds_sel_32
    _TSS_2_ss:     dw ds_sel_32


;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .data_tarea_2
USE32







;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .bss_tarea_2 nobits
USE32
;_NUMERO_TOTAL: resq 2






;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////