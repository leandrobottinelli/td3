;Pasos del programa:
;---------------------------------------------------------------------------------------
  ; Entro a modo_proteg
  ; Copio la funcion copy en rutinas(RAM)
  ; Llamo a la funcion copy para que me copie la ROM a nucleo (RAM)

  ; Espero interrupcion de tecla, mientras tengo el flag desactivado
  ; Espero interrupcion de timer, mientras tengo el flag desactivado

  ; Si el flag fue de timer:
  ; Incremento el CONTADOR_TIMER cada vez que se activa el flag (10 ms)
  ; Cuando llego a las 10 veces, Incremento _CONTADOR_TIMER_2 
  ; Logro contar cuantas veces paso 100 ms

  ; Si el flag fue de teclado:
  ; Cuando se produce la interrucion, la isr correspondiente activa el flag
  ; LLamo a la funcion LECTURA_TECLA y obtengo el codigo de la tecla
  ; En el main comparo cada caso, solo validando teclas con valores en hexa
  ; Si la tecla es valida, la guardo en un vector 16 posiciones, al comienzo de la tabla.
  ; Cuando se presiona la tecla enter, dejo de guardar teclas.
  ; Si el numero de teclas es 16 o mas, las guardo desde la primera como la MSB hasta la ultima.
  ; Si es menor a 16, hago lo mismo pero rellenando con ceros adelante.
  ; Previo compruebo si es par o impar.
  ; Voy guardando cada vector de teclas, ya acomodados uno debajo de otro en la tabla.

  ; NOTA: Las teclas las paso a traves de la pila 
;-----------------------------------------------------------------------------------


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

GLOBAL _CONTADOR_TECLAS
GLOBAL _ENTRADA_TABLA
GLOBAL _CONTADOR_TECLAS_BYTES
GLOBAL _flag_int_timer

GLOBAL FIN

EXTERN img_idtr
EXTERN img_gdtr_32

EXTERN cs_sel_32
EXTERN ds_sel_32

EXTERN LECTURA_TECLA
EXTERN CARGAR_TABLA
EXTERN CARGAR_TABLA_2


GLOBAL cs_sel
GLOBAL ds_sel
GLOBAL _flag_int_teclado
GLOBAL _flag_16_TECLAS


EXTERN _pic_configure
EXTERN _pit_configure


;----------------------------------------------------------------------------------
%define TECLA_0  0x0B
%define TECLA_1  0x02
%define TECLA_2  0x03
%define TECLA_3  0x04
%define TECLA_4  0x05
%define TECLA_5  0x06
%define TECLA_6  0x07
%define TECLA_7  0x08
%define TECLA_8  0x09
%define TECLA_9  0x0A
%define TECLA_A  0x1E
%define TECLA_B  0x30
%define TECLA_C  0x2E
%define TECLA_D  0x20
%define TECLA_E  0x12
%define TECLA_F  0x21
%define TECLA_ENTER  0x1C

%define BKP xchg bx,bx

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
  cli                ; Deshabilito interrupciones
  db 0x66            ; Requerido para direcciones mayores
  lgdt [cs:img_gdtr] ; que 0x00FFFFFFF. 
  mov eax,cr0        ; Habiltación bit de modo protegido. 
  or eax,1
  mov cr0,eax
 	
 jmp dword cs_sel:modo_proteg


 
USE32
modo_proteg:
  ;xchg bx,bx

  mov ax,ds_sel
  mov ds,ax
  mov ss,ax
  mov esp,__FIN_PILA


  push __INICIO_ROM_RUTINAS
  push __INICIO_RAM_RUTINAS
  push __LONGITUD_RUTINAS

  call __INICIO_ROM_RUTINAS  ; Copio la funcion copy en RAM a mano

  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_NUCLEO
  push __INICIO_RAM_NUCLEO
  push __LONGITUD_ROM


  call COPY_INIT            ; Copio parte la ROM en RAM desde
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
;xchg bx, bx


WHILE:

      mov ax,[_flag_int_timer]          ; Me fijo si vencio timer
      cmp ax, 0x01      
      jz Cien_ms

      mov bx, [_flag_int_teclado]       ; Me fijo si hubo tecla
      cmp bx, 0x01
      jz INT_TECLA
      jmp WHILE

  Cien_ms:
      mov ax,0x00
      mov [_flag_int_timer], ax         ; Reinicio el flag de timer

      mov ax, [_CONTADOR_TIMER]         
      cmp ax, 0x0A                      ; Me fijo si el timer vencio 10 veces 
      jz VENCE_TIMER

      mov eax,[_CONTADOR_TIMER]         ; Guardo cada 10 veces la base de tiempo
      inc eax
      mov [_CONTADOR_TIMER], eax
      jmp WHILE


  VENCE_TIMER:

    mov ax, 0x0
    mov [_CONTADOR_TIMER], ax
    mov eax,[_CONTADOR_TIMER_2]
    inc eax
    
    mov [_CONTADOR_TIMER_2], eax
    JMP WHILE


  INT_TECLA:
     
      call LECTURA_TECLA
      

    T_0:
      cmp al, TECLA_0
      mov bl, 0x0       ;Guardo el hexa de cada tecla     
      jz GUARDADO_HEXA

    T_1:
      cmp al, TECLA_1
      mov bl, 0x1 ;       ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA

    T_2:
      cmp al, TECLA_2 ; 
      mov bl, 0x2        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA

    T_3:
      cmp al, TECLA_3 ; 
      mov bl, 0x3        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA   

    T_4:
      cmp al, TECLA_4
      mov bl, 0x4        ;Guardo el hexa de cada tecla     
      jz GUARDADO_HEXA 

    T_5:
      cmp al, TECLA_5  
      mov bl, 0x5        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA   

    T_6:
      cmp al, TECLA_6
      mov bl, 0x6        ;Guardo el hexa de cada tecla     
      jz GUARDADO_HEXA   

    T_7:
      cmp al, TECLA_7  
      mov bl, 0x7        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA     
    
    T_8:
      cmp al, TECLA_8
      mov bl, 0x8        ;Guardo el hexa de cada tecla     
      jz GUARDADO_HEXA
    
    T_9:
      cmp al, TECLA_9 
      mov bl, 0x9        ;Guardo el hexa de cada tecla    
      jz GUARDADO_HEXA  
    
    T_A:
      cmp al, TECLA_A  
      mov bl, 0xA        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA
    
    T_B:
      cmp al, TECLA_B 
      mov bl, 0xB        ;Guardo el hexa de cada tecla    
      jz GUARDADO_HEXA  
    
    T_C:
      cmp al, TECLA_C 
      mov bl, 0xC        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA 
    
    T_D:
      cmp al, TECLA_D 
      mov bl, 0xD        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA 
    
    T_E:
      cmp al, TECLA_E 
      mov bl, 0xE        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA 

    T_F:
      cmp al, TECLA_F 
      mov bl, 0xF        ;Guardo el hexa de cada tecla   
      jz GUARDADO_HEXA 

    T_ENTER:
      cmp al, TECLA_ENTER  
      jz FIN


  jmp SIGUIENTE


    GUARDADO_HEXA:
      push bx
      call CARGAR_TABLA
      pop bx
      jmp SIGUIENTE


    SIGUIENTE:
    
      mov ax, 0x0
      mov [_flag_int_teclado], ax      ; Reinicio flag de teclado 
      sti                              ; Habilito interrupciones nuevamente
      jmp WHILE                        ; Espero nuevas teclas


    FIN:
      
      cmp byte[_CONTADOR_TECLAS],0x0   ; Me fijo si estoy parado en la primer pocision del vector
      jz CASO_TECLA_ENTER_SOLA
      JMP CASO_NORMAL


      CASO_TECLA_ENTER_SOLA:
      cmp byte[_flag_16_TECLAS],0x0    ; Me fijo si la cantidad de teclas fue  realmente 0 o multiplo de 16
      jz RESET                         ; Si fue 0, es porque solo se presiono la tecla ENTER

      CASO_NORMAL:
      BKP
      call CARGAR_TABLA_2

      RESET:
      mov ax, 0x0
      mov [_flag_int_teclado], ax     ; Reinicio flag de teclado 
      sti                             ; Habilito interrupciones nuevamente



jmp WHILE




;----------------------------------------------------------------------
section .datos

_CONTADOR_TECLAS: dq 0x00       ;Contador de teclas validas presionadas
_CONTADOR_TECLAS_BYTES: dq 0x0  ;Contador para tomar de a dos hexas, y ponerlos en un byte
_ENTRADA_TABLA: dq __INICIO_RAM_TABLA_DIGITOS + 0x10 ;Puntero a la primera entrada de tabla libre
_flag_int_teclado: dq 0x00      ;Flag si interrupio el teclado
_flag_16_TECLAS: dq 0x00        ;Flag si se presionaron mas de 16 teclas
_flag_int_timer: dq 0x00
_CONTADOR_TIMER: dq 0x00        ;Contador de interrupciones del PIT cada 10ms
_CONTADOR_TIMER_2: dq 0x00      ;Contador de interrupciones del PIT cada 100ms

 

