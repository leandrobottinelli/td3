GLOBAL isr0_handler_DE
GLOBAL isr1_handler_DB
GLOBAL isr2_handler_NMI
GLOBAL isr3_handler_BP
GLOBAL isr4_handler_OF
GLOBAL isr5_handler_BR
GLOBAL isr6_handler_UD
GLOBAL isr7_handler_NM
GLOBAL isr8_handler_DF
GLOBAL isr9_handler
GLOBAL isr10_handler_TS
GLOBAL isr11_handler_NP
GLOBAL isr12_handler_SS
GLOBAL isr13_handler_GP
GLOBAL isr14_handler_PF
GLOBAL isr15_handler
GLOBAL isr16_handler_MF
GLOBAL isr17_handler_AC
GLOBAL isr18_handler_MC
GLOBAL isr19_handler_XF
GLOBAL isr20_31_handler


GLOBAL POLLING

EXTERN FIN_POLLING
EXTERN CARGAR_TABLA
EXTERN __INICIO_RAM_TECLADO_RUTINA

%define _PUERTO_TECLADO  0x64;
%define _PUERTO_TECLADO_CODIGO 0x60;
;-------------------------------------------------------------------------------

section .rutina_teclado_isr
USE32

POLLING:

in al, _PUERTO_TECLADO 
bt eax, 0x00
jnc POLLING


in al, _PUERTO_TECLADO_CODIGO
bt ax, 0x7

xchg bx,bx
cmp al, 0x1F		;Si detecto que la tecla fue "s" termino el programa
jz FIN_POLLING


jmp CARGADO_TABLA


CARGADO_TABLA:

push ax
call CARGAR_TABLA
pop ax
ret


;---------------------------------------------------------------------
; Handlers ISRs

default_isr:
   nop
   xchg bx,bx
   nop
   hlt


isr0_handler_DE:
   mov edx, 0
   jmp default_isr

isr1_handler_DB:
   mov edx, 1
   jmp default_isr


isr2_handler_NMI:
   mov edx, 2
   jmp default_isr


isr3_handler_BP:
   mov edx, 3
   jmp default_isr


isr4_handler_OF:
   mov edx, 4
   jmp default_isr


isr5_handler_BR:
   mov edx, 5
   jmp default_isr


isr6_handler_UD:
   mov edx, 6
   jmp default_isr


isr7_handler_NM:
   mov edx, 7
   jmp default_isr


isr8_handler_DF:
   mov edx, 8
   jmp default_isr

isr9_handler:
   mov edx, 9
   jmp default_isr


isr10_handler_TS:
   mov edx, 10
   jmp default_isr


isr11_handler_NP:
   mov edx, 11
   jmp default_isr


isr12_handler_SS:
   mov edx, 12
   jmp default_isr


isr13_handler_GP:
   mov edx, 13
   jmp default_isr


isr14_handler_PF:
   mov edx, 14
   jmp default_isr

isr15_handler:
   mov edx, 15
   jmp default_isr

isr16_handler_MF:
   mov edx, 16
   jmp default_isr


isr17_handler_AC:
   mov edx, 17
   jmp default_isr


isr18_handler_MC:
   mov edx, 18
   jmp default_isr


isr19_handler_XF:
   mov edx, 19
   jmp default_isr


isr20_31_handler:
   mov edx, 20
   jmp default_isr


isr32_47_handler:
   mov edx, 32
   jmp default_isr






















