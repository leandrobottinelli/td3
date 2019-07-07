
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
EXTERN __FIN_PILA_USUARIO_TAREA_2

EXTERN cs_sel_32_usuario
EXTERN ds_sel_32_usuario
EXTERN ds_sel_32_nucleo





;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------
section .text_tarea_2
USE32

TAREA_2:

     mov eax, 0x02
     mov ebx, _BUFFER_TABLA_TAREA_2
     mov ecx, 0xE00
     int 0x80


    mov eax, 0x00
    mov edx, _BUFFER_TABLA_TAREA_2 + 0x10  ; Comienzo desde lel primero numero de la tabla
    mov [_NUMERO_TOTAL_TAREA_2], eax                    ; Pongo en cero la parte baja de la suma total
    mov [_NUMERO_TOTAL_TAREA_2 + 0x04], eax             ; Pongo en cero la parte alta de la suma total


    LP:
    cmp edx, _BUFFER_TABLA_TAREA_2 + 0xE00                     ; Chequeo si el puntero es siguiente numero de la tabla a cargar 
    jz FIN                                ; Dejo de sumar y vuelvo
    mov eax,[edx]                            
    add [_NUMERO_TOTAL_TAREA_2], eax                    ; Sumo la parte baja del numero nuevo al total
    mov eax,[edx+0x04]                          ; Copio la parte alta del numero nuevo
    jc CARRY                                    ; Si la suma de la parte baja tiene carry lo sumo en la parte alta
    jmp N_CARRY   



    CARRY: 
    add byte[_NUMERO_TOTAL_TAREA_2+0x04], 0x01          ; Caso de carry en la parte baja, lo sumo a la parte alta



    N_CARRY:
    add [_NUMERO_TOTAL_TAREA_2+0x04], eax               ; Sumo la parte alta del numero nuevo al total
    add edx , 0x10                              ; Corro el puntero al siguiente numero de la tabla

    jmp LP

    FIN:
    mov eax, 0x03

    mov ebx, 0x60                           ; Guardo el valor de COLUMNAS  
    mov ecx, 0x500                          ; Guardo el valor de FILAS
    mov edx, _NUMERO_TOTAL_TAREA_2
    int 0x80

    mov eax, 0x01
    int 0x80

    jmp TAREA_2

;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .tss_tarea_2
USE32

TSS_TAREA_2:

    _TSS_2_reservado:      resw 2 
    _TSS_2_esp_0:          dd __FIN_PILA_NUCLEO_TAREA_2
    _TSS_2_ss_0:           dw ds_sel_32_nucleo    
    _TSS_2_reservado_0:    resw 1 
    _TSS_2_esp_1:          resw 2 
    _TSS_2_ss_1:           resw 1 
    _TSS_2_reservado_1:    resw 1 
    _TSS_2_esp_2:          resw 2 
    _TSS_2_ss_2:           resw 1 
    _TSS_2_reservado_2:    resw 1 
    _TSS_2_cr3:            resw 2 
    _TSS_2_eip:            dd TAREA_2
    _TSS_2_eflags:         dd 0x202
    _TSS_2_eax:            resw 2 
    _TSS_2_ecx:            resw 2 
    _TSS_2_edx:            resw 2 
    _TSS_2_ebx:            resw 2 
    _TSS_2_esp:            dd __FIN_PILA_USUARIO_TAREA_2
    _TSS_2_ebp:            resw 2 
    _TSS_2_esi:            resw 2 
    _TSS_2_edi:            resw 2
    _TSS_2_es:             dw ds_sel_32_usuario
    _TSS_2_reservado_es:   resw 1
    _TSS_2_cs:             dw cs_sel_32_usuario     
    _TSS_2_reservado_cs:   resw 1
    _TSS_2_ss:             dw ds_sel_32_usuario
    _TSS_2_reservado_ss:   resw 1
    _TSS_2_ds:             dw ds_sel_32_usuario
    _TSS_2_reservado_ds:   resw 1


;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .data_tarea_2
USE32


;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .bss_tarea_2 nobits
USE32
_NUMERO_TOTAL_TAREA_2: resq 2
_BUFFER_TABLA_TAREA_2: resq 10

;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////