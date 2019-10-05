
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
GLOBAL _TSS_1_simd

EXTERN __FIN_PILA_NUCLEO_TAREA_1
EXTERN __FIN_PILA_USUARIO_TAREA_1

EXTERN cs_sel_32_usuario
EXTERN ds_sel_32_usuario
EXTERN ds_sel_32_nucleo


%define cantidad_numeros 0xE00



;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------
section .text_tarea_1
USE32

TAREA_1:

  ; xchg bx, bx
   mov eax, 0x02
   mov ebx, _BUFFER_TABLA_TAREA_1
   mov ecx, cantidad_numeros

   ;xchg bx, bx
   int 0x80

    ;xchg bx,bx

    movdqu xmm0, [_BUFFER_TABLA_TAREA_1 + 0x10]           
    mov edx, _BUFFER_TABLA_TAREA_1 + 0x20  				; Comienzo desde lel primero numero de la tabla

    LP:
    movdqu xmm1, [edx] 
    paddq  xmm0, xmm1
    cmp edx, _BUFFER_TABLA_TAREA_1 + cantidad_numeros 
    je RESULTADO 
    add edx , 0x10                              		; Corro el puntero al siguiente numero de la tabla
	jmp LP

	RESULTADO:
	movdqu  [_NUMERO_TOTAL_TAREA_1], xmm0 





;    mov eax, 0x00
;    mov edx, _BUFFER_TABLA_TAREA_1 + 0x10  				; Comienzo desde lel primero numero de la tabla
;    mov [_NUMERO_TOTAL_TAREA_1], eax                    ; Pongo en cero la parte baja de la suma total
;    mov [_NUMERO_TOTAL_TAREA_1 + 0x04], eax             ; Pongo en cero la parte alta de la suma total
;
;
;    LP:
;    cmp edx, _BUFFER_TABLA_TAREA_1 + 0xE00     			; Chequeo si el puntero es siguiente numero de la tabla a cargar 
;    je FIN                                      		; Dejo de sumar y vuelvo
;    mov eax,[edx]                            
;    add [_NUMERO_TOTAL_TAREA_1], eax        		    ; Sumo la parte baja del numero nuevo al total
;    mov eax,[edx+0x04]                          		; Copio la parte alta del numero nuevo
;    jc CARRY                                    		; Si la suma de la parte baja tiene carry lo sumo en la parte alta
;    jmp N_CARRY   
;
;
;
;    CARRY: 
;    add byte[_NUMERO_TOTAL_TAREA_1 + 0x04], 0x01        ; Caso de carry en la parte baja, lo sumo a la parte alta
;
;
;
;    N_CARRY:
;    add [_NUMERO_TOTAL_TAREA_1 + 0x04], eax             ; Sumo la parte alta del numero nuevo al total
;    add edx , 0x10                              		; Corro el puntero al siguiente numero de la tabla
;
;    jmp LP

;
    FIN:

    mov eax, 0x03

    mov ebx, 0x20                           			; Guardo el valor de COLUMNAS  
    mov ecx, 0x500                         				; Guardo el valor de FILAS
    mov edx, _NUMERO_TOTAL_TAREA_1
    int 0x80

    mov eax, 0x01
    int 0x80

    jmp TAREA_1
;
;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .tss_tarea_1
USE32
ALIGN 64
TSS_TAREA_1:

    _TSS_1_reservado:      resw 2 
    _TSS_1_esp_0:          dd __FIN_PILA_NUCLEO_TAREA_1 
    _TSS_1_ss_0:           dw ds_sel_32_nucleo    
    _TSS_1_reservado_0:    resw 1 
    _TSS_1_esp_1:          resw 2 
    _TSS_1_ss_1:           resw 1 
    _TSS_1_reservado_1:    resw 1 
    _TSS_1_esp_2:          resw 2 
    _TSS_1_ss_2:           resw 1 
    _TSS_1_reservado_2:    resw 1 
    _TSS_1_cr3:            resw 2 
    _TSS_1_eip:            dd TAREA_1
    _TSS_1_eflags:         dd 0x202
    _TSS_1_eax:            resw 2 
    _TSS_1_ecx:            resw 2 
    _TSS_1_edx:            resw 2 
    _TSS_1_ebx:            resw 2 
    _TSS_1_esp:            dd __FIN_PILA_USUARIO_TAREA_1
    _TSS_1_ebp:            resw 2 
    _TSS_1_esi:            resw 2 
    _TSS_1_edi:            resw 2
    _TSS_1_es:             dw ds_sel_32_usuario
    _TSS_1_reservado_es:   resw 1
    _TSS_1_cs:             dw cs_sel_32_usuario     
    _TSS_1_reservado_cs:   resw 1
    _TSS_1_ss:             dw ds_sel_32_usuario
    _TSS_1_reservado_ss:   resw 1
    _TSS_1_ds:             dw ds_sel_32_usuario
    _TSS_1_reservado_ds:   resw 1
    _RESERVED:             resb 8
    _TSS_1_simd:           resb 512

;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .data_tarea_1
USE32


;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .bss_tarea_1 nobits
USE32
_NUMERO_TOTAL_TAREA_1: resq 2
_BUFFER_TABLA_TAREA_1: resq 10

;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////