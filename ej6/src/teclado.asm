GLOBAL POLLING

EXTERN FIN_POLLING
EXTERN CARGAR_TABLA
EXTERN __INICIO_RAM_TECLADO_RUTINA

%define _PUERTO_TECLADO  0x64;
%define _PUERTO_TECLADO_CODIGO 0x60;

section .rutina_teclado
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
