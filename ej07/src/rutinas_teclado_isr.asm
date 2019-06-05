GLOBAL isr0_handler_DE
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
GLOBAL isr32_handler
GLOBAL isr33_handler



GLOBAL LECTURA_TECLA
EXTERN FIN
EXTERN __INICIO_RAM_TECLADO_RUTINA
EXTERN flag_int_teclado


%define _PUERTO_TECLADO  0x64;
%define _PUERTO_TECLADO_CODIGO 0x60;
;-------------------------------------------------------------------------------

section .rutina_teclado_isr
USE32

POLLING:

in al, _PUERTO_TECLADO 
bt eax, 0x00
jnc POLLING

LECTURA_TECLA:

in al, _PUERTO_TECLADO_CODIGO
bt ax, 0x7							 ; Me fijo si la tecla fue presionada o soltada
jc POLLING 							 ; Me quedo solo con la tecla persionada

xchg bx,bx
ret


;jmp CARGADO_TABLA


;CARGADO_TABLA:

;push ax
;call CARGAR_TABLA
;pop ax
;ret


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


isr32_handler:
   mov edx, 32
   jmp default_isr

isr33_handler:

   xchg bx,bx
   pushad
   mov ax, 0x1
   mov [flag_int_teclado],ax
   mov al,0x20       ;Codigo para avisar al PIC que atendi la int 
   out 0x20,al
   popad
   iret






















