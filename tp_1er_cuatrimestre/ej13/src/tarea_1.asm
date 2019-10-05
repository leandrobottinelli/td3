
GLOBAL TAREA_1
GLOBAL TSS_TAREA_1
GLOBAL _TSS_1_eax
GLOBAL _TSS_1_ebx
GLOBAL _TSS_1_ecx
GLOBAL _TSS_1_edx
GLOBAL _TSS_1_edi
GLOBAL _TSS_1_esi
GLOBAL _TSS_1_ebp
GLOBAL _TSS_1_esp
GLOBAL _TSS_1_eip
GLOBAL _TSS_1_eflags
GLOBAL _TSS_1_cs
GLOBAL _TSS_1_ds
GLOBAL _TSS_1_es
GLOBAL _TSS_1_ss


EXTERN __FIN_PILA_NUCLEO_TAREA_1
EXTERN cs_sel_32
EXTERN ds_sel_32



EXTERN _NUMERO_TOTAL

EXTERN _ENTRADA_TABLA
EXTERN __INICIO_RAM_TABLA_DIGITOS




;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------
section .text_tarea_1
USE32

TAREA_1:

    mov eax, 0x00
    mov edx, __INICIO_RAM_TABLA_DIGITOS + 0x10  ; Comienzo desde lel primero numero de la tabla
    mov [_NUMERO_TOTAL], eax                    ; Pongo en cero la parte baja de la suma total
    mov [_NUMERO_TOTAL + 0x04], eax             ; Pongo en cero la parte alta de la suma total


    LP:
    cmp edx, [_ENTRADA_TABLA]                   ; Chequeo si el puntero es siguiente numero de la tabla a cargar 
    jz FIN                                      ; Dejo de sumar y vuelvo
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


    FIN:
    hlt
    jmp TAREA_1
;
;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .tss_tarea_1
USE32

TSS_TAREA_1:
    _TSS_1_eax:    resw 2 
    _TSS_1_ebx:    resw 2 
    _TSS_1_ecx:    resw 2 
    _TSS_1_edx:    resw 2 
    _TSS_1_edi:    resw 2 
    _TSS_1_esi:    resw 2 
    _TSS_1_ebp:    resw 2 
    _TSS_1_esp:    dd __FIN_PILA_NUCLEO_TAREA_1 
    _TSS_1_eip:    dd TAREA_1
    _TSS_1_eflags: dd 0x202
    _TSS_1_cs:     dw cs_sel_32     
    _TSS_1_ds:     dw ds_sel_32
    _TSS_1_es:     dw ds_sel_32
    _TSS_1_ss:     dw ds_sel_32

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