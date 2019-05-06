;Pasos del programa:

  ; Entro a modo_proteg
  ; Copio la funcion copy en rutinas(RAM)
  ; Llamo a la funcion copy para que me copie la ROM a nucleo (RAM)
  ;
  ; Voy a pol:, donde llamo funcion pooling para el teclado
  ; En pooling del teclado pregunto por si hubo tecla y despues cual fue
  ; Si la tecla fue "s" voy a FIN_POLLING y hago halt
  ; Si es cualquier otra tecla, llamo a la funcion CARGAR_TABLA 
  ; Almaceno cada tecla en la tabla, para moverme uso _CONTADOR_TABLA
  ; El cual esta en .datos, asi que guardo en la pocision que tiene el contador
  ; Y luego de alamacenada la tecla en la posicion indicada, incremento el contador
  ; Finalmente guardo el nuevo valor del contador y vuelvo a pooling.

  ; NOTA: Las teclas las paso a traves de la pila   

EXTERN __FIN_PILA
EXTERN __SIZE_PILA

EXTERN COPY_INIT
EXTERN POLLING

EXTERN __INICIO_RAM_RUTINAS
EXTERN __INICIO_ROM_RUTINAS
EXTERN __INICIO_ROM
EXTERN __INICIO_RAM_NUCLEO
EXTERN __INICIO_ROM_NUCLEO

EXTERN __INICIO_RAM_TECLADO_RUTINA
EXTERN __INICIO_ROM_TECLADO_RUTINA

EXTERN __INICIO_ROM_TABLA_DIGITOS 
EXTERN __INICIO_RAM_TABLA_DIGITOS 

EXTERN __INICIO_ROM_DATOS 
EXTERN __INICIO_RAM_DATOS


EXTERN __LONGITUD_RUTINAS
EXTERN __LONGITUD_ROM
EXTERN __LONGITUD_TECLADO_RUTINA
EXTERN __LONGITUD_DATOS

GLOBAL _CONTADOR_TABLA
GLOBAL FIN_POLLING





section .reset
arranque:
USE16
mov ax,0
jmp ax
;salto a inicio16
times 16-($-arranque) db 0

section .init
jmp inicio
gdt:
          db 0,0,0,0,0,0,0,0  ;Descriptor nulo
ds_sel    equ $-gdt
          db 0xFF, 0xFF, 0, 0, 0, 0x92, 0xCF, 0
cs_sel    equ $-gdt
          db 0xFF, 0xFF, 0, 0, 0, 0x9A, 0xCF, 0

long_gdt equ $-gdt

img_gdtr:
		  dw long_gdt-1
		  dd gdt


inicio:		  
 cli       ;Deshabilito interrupciones
 

  db 0x66            ;Requerido para direcciones mayores
  lgdt  [cs:img_gdtr] ;que 0x00FFFFFFF. 
  mov eax,cr0        ;Habiltación bit de modo protegido. 
  or eax,1
  mov cr0,eax
 	
 jmp dword cs_sel:modo_proteg
 
USE32
modo_proteg:
  xchg bx,bx

  mov ax,ds_sel
  mov ds,ax
  mov ss,ax
  mov esp,__FIN_PILA


  push __INICIO_ROM_RUTINAS
  push __INICIO_RAM_RUTINAS
  push __LONGITUD_RUTINAS

  call __INICIO_ROM_RUTINAS ;Copio la funcion copy en RAM a mano

  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_NUCLEO
  push __INICIO_RAM_NUCLEO
  push __LONGITUD_ROM


  call COPY_INIT            ;Copio toda la ROM en RAM desde
  pop eax                   ;funcion copy en RAM
  pop eax
  pop eax

  jmp nucleos
 

 ;----------------------------------------------------------------------

section .nucleo


nucleos:   

  push __INICIO_ROM_TECLADO_RUTINA
  push __INICIO_RAM_TECLADO_RUTINA
  push __LONGITUD_TECLADO_RUTINA 

  call COPY_INIT
  
  pop eax
  pop eax
  pop eax

  push __INICIO_ROM_DATOS
  push __INICIO_RAM_DATOS
  push __LONGITUD_DATOS

  call COPY_INIT
  
  pop eax
  pop eax
  pop eax


pol:
  push eax
  call POLLING       ; Voy a la funcion de pooling en forma de loop         
  jmp pol            ; hasta la tecla "s"

FIN_POLLING:
  nop 
  halt               ; Se presiono tecla "s", hago halt de todo
  jmp FIN_POLLING

;----------------------------------------------------------------------
section .datos

_CONTADOR_TABLA: dq __INICIO_RAM_TABLA_DIGITOS 




 

