
  ;Entro a modo_proteg
  ; Necesito copiar la funcion copy en rutinas
  ; Llamo a la funcion copy para que me copie la ROM a nucleo


EXTERN __FIN_PILA
EXTERN __SIZE_PILA

EXTERN COPY_INIT
EXTERN __INICIO_ROM_RUTINAS
EXTERN __INICIO_ROM
EXTERN __INICIO_NUCLEO
EXTERN __INICIO_RAM_RUTINAS
EXTERN __LONGITUD_RUTINAS
EXTERN __LONGITUD_ROM 

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

  call __INICIO_ROM_RUTINAS ;esta es la direccion VMA

  pop eax
  pop eax
  pop eax


  push __INICIO_ROM;copio el resto de la rom a una seccion de la ram
  push __INICIO_NUCLEO
  push __LONGITUD_ROM ;__LONGITUD_ROM 

  call COPY_INIT
  
  pop eax
  pop eax
  pop eax

  jmp __INICIO_NUCLEO ;call? PREGUNTAR

section .nucleo

nucleos:   
  db 0xAB
  db 0xBB
  db 0xCE
  db 0xEE
  jmp $ 

;long_nucleo EQU $-nucleos			

	



 

