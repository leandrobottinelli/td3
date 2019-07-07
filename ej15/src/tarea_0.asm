GLOBAL TAREA_0
GLOBAL TSS_TAREA_0
GLOBAL _TSS_0_eax
GLOBAL _TSS_0_ebx
GLOBAL _TSS_0_ecx
GLOBAL _TSS_0_edx
GLOBAL _TSS_0_edi
GLOBAL _TSS_0_esi
GLOBAL _TSS_0_ebp
GLOBAL _TSS_0_esp
GLOBAL _TSS_0_eip
GLOBAL _TSS_0_eflags
GLOBAL _TSS_0_cs
GLOBAL _TSS_0_ds
GLOBAL _TSS_0_es
GLOBAL _TSS_0_ss


EXTERN __FIN_PILA_NUCLEO_TAREA_0
EXTERN __FIN_PILA_USUARIO_TAREA_0
EXTERN cs_sel_32_nucleo
EXTERN ds_sel_32_nucleo


;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------
section .text_tarea_0
USE32

TAREA_0:
   hlt
   mov eax, 0x00
   jmp TAREA_0

;/////////////////////////////////////////////////////////////////////////////////////////////////

section .tss_tarea_0
USE32

TSS_TAREA_0:
    _TSS_0_reservado:      resw 2 
    _TSS_0_esp_0:          dd __FIN_PILA_NUCLEO_TAREA_0 
    _TSS_0_ss_0:           dw ds_sel_32_nucleo     
    _TSS_0_reservado_0:    resw 1 
    _TSS_0_esp_1:          resw 2 
    _TSS_0_ss_1:           resw 1 
    _TSS_0_reservado_1:    resw 1 
    _TSS_0_esp_2:          resw 2 
    _TSS_0_ss_2:           resw 1 
    _TSS_0_reservado_2:    resw 1 
    _TSS_0_cr3:            resw 2 
    _TSS_0_eip:            dd TAREA_0
    _TSS_0_eflags:         dd 0x202
    _TSS_0_eax:            resw 2 
    _TSS_0_ecx:            resw 2 
    _TSS_0_edx:            resw 2 
    _TSS_0_ebx:            resw 2 
    _TSS_0_esp:            dd __FIN_PILA_USUARIO_TAREA_0
    _TSS_0_ebp:            resw 2 
    _TSS_0_esi:            resw 2 
    _TSS_0_edi:            resw 2
    _TSS_0_es:             dw ds_sel_32_nucleo
    _TSS_0_reservado_es:   resw 1
    _TSS_0_cs:             dw cs_sel_32_nucleo     
    _TSS_0_reservado_cs:   resw 1
    _TSS_0_ss:             dw ds_sel_32_nucleo
    _TSS_0_reservado_ss:   resw 1
    _TSS_0_ds:             dw ds_sel_32_nucleo
    _TSS_0_reservado_ds:   resw 1



;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .data_tarea_0
USE32







;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////

section .bss_tarea_0 nobits
USE32






;-------------------------------------------------------------------------------------------------
;/////////////////////////////////////////////////////////////////////////////////////////////////