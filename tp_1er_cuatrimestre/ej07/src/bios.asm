;Pasos del programa:
;-------------------
  ; Entro a modo_proteg
  ; Copio la funcion copy en rutinas(RAM)
  ; Llamo a la funcion copy para que me copie la ROM a nucleo (RAM)

  ; Espero interrupcion de tecla, mientras tengo el flag desactivado
  ; Cuando se produce la interrucion, la isr correspondiente activa el flag
  ; LLamo a la funcion LECTURA_TECLA y obtengo el codigo de la tecla
  ; En el main comparo cada caso y genero la excepcion correspondiente
  ; En caso de quela tecla sea S, hago halt del programa

  ; NOTA: Las teclas las paso a traves de la pila   
;-----------------------------------------------------------------------
EXTERN __FIN_PILA
EXTERN __SIZE_PILA

EXTERN COPY_INIT
EXTERN POLLING

EXTERN __INICIO_RAM_RUTINAS
EXTERN __INICIO_ROM_RUTINAS
EXTERN __INICIO_ROM
EXTERN __INICIO_RAM_NUCLEO
EXTERN __INICIO_ROM_NUCLEO

EXTERN __INICIO_RAM_SYS_TABLES
EXTERN __INICIO_ROM_SYS_TABLES
EXTERN __LONGITUD_SYS_TABLES

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

GLOBAL FIN

EXTERN img_idtr
EXTERN img_gdtr_32

EXTERN cs_sel_32
EXTERN ds_sel_32

EXTERN LECTURA_TECLA

GLOBAL cs_sel
GLOBAL ds_sel
GLOBAL flag_int_teclado


EXTERN _pic_configure
EXTERN _pit_configure


;----------------------------------------------------------------------------------
%define TECLA_S  0x1F
%define TECLA_Y  0x15
%define TECLA_U  0x16
%define TECLA_I  0x17
%define TECLA_O  0x18


;----------------------------------------------------------------------------------



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
  cli       		 ; Deshabilito interrupciones
  db 0x66            ; Requerido para direcciones mayores
  lgdt [cs:img_gdtr] ; que 0x00FFFFFFF. 
  mov eax,cr0        ; Habiltación bit de modo protegido. 
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


  call COPY_INIT            ; Copio parte de la ROM en RAM desde
  pop eax                   ; funcion copy en RAM
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




  push __INICIO_ROM_SYS_TABLES
  push __INICIO_RAM_SYS_TABLES
  push __LONGITUD_SYS_TABLES

  call COPY_INIT              ;Copio la GDT e IDT a sys_tables(RAM)
    
  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_DATOS
  push __INICIO_RAM_DATOS
  push __LONGITUD_DATOS

  call COPY_INIT                ;Copio seccion de datos. Contador de la tabla de digitos
  
  pop eax
  pop eax
  pop eax

lgdt [cs:img_gdtr_32] 

lidt [img_idtr]                    
call _pic_configure
call _pit_configure
sti
xchg bx, bx


WHILE:

      mov bx, [flag_int_teclado]
      cmp bx, 0x00
      jz WHILE


      call LECTURA_TECLA
      sti

  UD:
      cmp al, TECLA_U     ; Excepcion UD (Undefined Opcode)
      jnz DE
      mov byte[UD], 0xFF  ; Modifico el codigo de instruccion del compare
      jmp UD              ; Salto para ejecutarlo

  DE:
      cmp al, TECLA_Y     ; Excepcion DE (Divide Error) 
      jnz DF
      mov eax, 0x10
      mov ecx, 0x00
      div ecx

  DF:
      cmp al, TECLA_I     ; Excepcion DF (Double Fault)
      jnz GP

  GP:
      cmp al, TECLA_O     ; Excepcion GP (General Protection) 
      jnz SHUTDOWN
      mov ax, 0xFFFF
      mov ss, ax
        
  SHUTDOWN:
      cmp al, TECLA_S ; 
      jz FIN    

mov ax, 0x0
mov [flag_int_teclado], ax
jmp WHILE


FIN:
nop 
hlt                       ; Se presiono tecla "s", hago halt de todo
jmp FIN




;----------------------------------------------------------------------
section .datos

_CONTADOR_TABLA: dq __INICIO_RAM_TABLA_DIGITOS 

flag_int_teclado: db 0x00



 

