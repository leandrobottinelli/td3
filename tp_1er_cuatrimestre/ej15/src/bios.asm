;Pasos del programa:
;---------------------------------------------------------------------------------------
  ; Entro a modo_proteg
  ; Copio la funcion copy en rutinas(RAM)
  ; Llamo a la funcion copy para que me copie la ROM a nucleo (RAM)

  ; Ejecuto en RAM, donde cargo tablas de paginacion
  ; Activo paginacion y copio todas las secciones de ROM a RAM

  ; Espero interrupcion de tecla, mientras tengo el flag desactivado
  ; Espero interrupcion de timer, mientras tengo el flag desactivado

  ; Si el flag fue de timer:
  ; Incremento el CONTADOR_TIMER cada vez que se activa el flag (10 ms)
  ; Cuando llego a las 10 veces, Incremento _CONTADOR_TIMER_2  y muestro por pantalla el numero
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


EXTERN __INICIO_RAM_ISR
EXTERN __INICIO_ROM_ISR
EXTERN __INICIO_RAM_SYS_TABLES
EXTERN __INICIO_ROM_SYS_TABLES
EXTERN __INICIO_RAM_PAGE_TABLES
EXTERN __INICIO_ROM_PAGE_TABLES
EXTERN __INICIO_ROM_TABLA_DIGITOS 
EXTERN __INICIO_RAM_TABLA_DIGITOS 
EXTERN __INICIO_RAM_TEXT_TAREA_0
EXTERN __INICIO_ROM_TEXT_TAREA_0
EXTERN __INICIO_RAM_TEXT_TAREA_1
EXTERN __INICIO_ROM_TEXT_TAREA_1
EXTERN __INICIO_RAM_TEXT_TAREA_2
EXTERN __INICIO_ROM_TEXT_TAREA_2
EXTERN __INICIO_ROM_TSS_TAREA_0
EXTERN __INICIO_ROM_TSS_TAREA_1
EXTERN __INICIO_ROM_TSS_TAREA_2

EXTERN __INICIO_RAM_NUCLEO
EXTERN __INICIO_ROM_NUCLEO
EXTERN __INICIO_ROM_DATOS 
EXTERN __INICIO_RAM_DATOS
EXTERN __INICIO_ROM_BSS 
EXTERN __INICIO_RAM_BSS
EXTERN __INICIO_RAM_RUTINAS
EXTERN __INICIO_ROM_RUTINAS
EXTERN __INICIO_ROM

EXTERN __LONGITUD_ISR
EXTERN __LONGITUD_SYS_TABLES
EXTERN __LONGITUD_PAGE_TABLES
EXTERN __LONGITUD_RUTINAS
EXTERN __LONGITUD_NUCLEO
EXTERN __LONGITUD_DATOS
EXTERN __LONGITUD_BSS
EXTERN __LONGITUD_TEXT_TAREA_0
EXTERN __LONGITUD_TEXT_TAREA_1
EXTERN __LONGITUD_TEXT_TAREA_2
EXTERN __LONGITUD_TSS_TAREA_0
EXTERN __LONGITUD_TSS_TAREA_1
EXTERN __LONGITUD_TSS_TAREA_2

EXTERN __INICIO_PILA_NUCLEO
EXTERN __FIN_PILA_NUCLEO
EXTERN __SIZE_PILA_NUCLEO
EXTERN __FIN_PILA_NUCLEO_TAREA_0
EXTERN __INICIO_PILA_NUCLEO_TAREA_0



EXTERN __DIR_FISICA_ISR            
EXTERN __DIR_FISICA_VIDEO         
EXTERN __DIR_FISICA_SYS_TABLES    
EXTERN __DIR_FISICA_NUCLEO        
EXTERN __DIR_FISICA_TABLA_DIGITOS 
EXTERN __DIR_FISICA_TEXT_TAREA_0
EXTERN __DIR_FISICA_TEXT_TAREA_1  
EXTERN __DIR_FISICA_TEXT_TAREA_2  
EXTERN __DIR_FISICA_BSS_TAREA_1   
EXTERN __DIR_FISICA_DATA_TAREA_1  
EXTERN __DIR_FISICA_DATOS         
EXTERN __DIR_FISICA_RUTINAS       
EXTERN __DIR_FISICA_TSS_TAREA_0  
EXTERN __DIR_FISICA_TSS_TAREA_1  
EXTERN __DIR_FISICA_TSS_TAREA_2  


EXTERN __DIR_FISICA_PAGE_TABLES_0
EXTERN __DIR_FISICA_PAGE_TABLES_1
EXTERN __DIR_FISICA_PAGE_TABLES_2
;---------------------------------------------------------------------------------------------------

GLOBAL _CONTADOR_TECLAS
GLOBAL _ENTRADA_TABLA
GLOBAL _CONTADOR_TECLAS_BYTES
GLOBAL _CONTADOR_TIMER
GLOBAL _BUFFER_NUMERO_PANTALLA
GLOBAL _FALLO_PAGINA_NUMERO
GLOBAL _CONTADOR_TABLAS_PAGINAS
GLOBAL _flag_int_timer
GLOBAL _CONTADOR_PAGINAS_NO_PRESENTES
GLOBAL _CONTADOR_TAREA_1
GLOBAL _CONTADOR_TAREA_2
GLOBAL _TAREA_ACTUAL
GLOBAL _TAREA_FUTURA


EXTERN COPY_INIT
EXTERN POLLING

GLOBAL FIN

GLOBAL cs_sel
GLOBAL ds_sel

EXTERN img_idtr
EXTERN img_gdtr_32
EXTERN tss_32
EXTERN cs_sel_32_nucleo
EXTERN ds_sel_32_nucleo

EXTERN LECTURA_TECLA
EXTERN CARGAR_TABLA
EXTERN CARGAR_TABLA_2
EXTERN TAREA_0
EXTERN TAREA_1
EXTERN TAREA_2
GLOBAL _NUMERO_TOTAL

GLOBAL _flag_int_teclado
GLOBAL _flag_16_TECLAS


EXTERN _pic_configure
EXTERN _pit_configure
EXTERN pantalla_init

EXTERN MOSTRAR_PANTALLA
EXTERN BUFFER_DOBLE_OFFS
EXTERN PAGINACION_INIT
;------------------------------------------------------------------------------------------------------------

%define BKP xchg bx,bx

;------------------------------------------------------------------------------------------------------------

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
  cli                ;Deshabilito interrupciones
  call pantalla_init

  db 0x66            ;Requerido para direcciones mayores
  lgdt [cs:img_gdtr] ;que 0x00FFFFFFF. 
  mov eax,cr0        ;Habiltación bit de modo protegido. 
  or eax,1
  mov cr0,eax
  
 	
 jmp dword cs_sel:modo_proteg
BKP

 
USE32
modo_proteg:


  mov ax,ds_sel
  mov ds,ax
  mov ss,ax
  mov es,ax
  mov esp,__FIN_PILA_NUCLEO -1
  mov ebp,__INICIO_PILA_NUCLEO 



;--------------------------------------------------------------------------------------------------------------------


  push __INICIO_ROM_RUTINAS
  push __DIR_FISICA_RUTINAS
  push __LONGITUD_RUTINAS
  
  call __INICIO_ROM_RUTINAS ;Copio la funcion copy en RAM a mano

  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_NUCLEO
  push __DIR_FISICA_NUCLEO
  push __LONGITUD_NUCLEO


  call COPY_INIT            ;Copio parte de la ROM en RAM desde
  pop eax                   ;funcion copy en RAM
  pop eax
  pop eax


  jmp nucleos
 
;------------------------------------------------------------------------------------------------------------

section .nucleo


nucleos:   


  call PAGINACION_INIT                  ; Cargo el DIRECTORIO y TABLAS de paginacion  



  push __INICIO_ROM_ISR
  push __DIR_FISICA_ISR
  push __LONGITUD_ISR 

  call COPY_INIT
  
  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_SYS_TABLES
  push __DIR_FISICA_SYS_TABLES
  push __LONGITUD_SYS_TABLES

  call COPY_INIT                        ; Copio la GDT e IDT a sys_tables(RAM)
    
  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_DATOS
  push __DIR_FISICA_DATOS
  push __LONGITUD_DATOS

  call COPY_INIT                        ; Copio seccion de datos. Contador de la tabla de digitos
  
  pop eax
  pop eax
  pop eax


  
  push __INICIO_ROM_TEXT_TAREA_0
  push __DIR_FISICA_TEXT_TAREA_0
  push __LONGITUD_TEXT_TAREA_0

  call COPY_INIT                        ; Copio el codigo de la tarea_0 a RAM
    
  pop eax
  pop eax
  pop eax


  push __INICIO_ROM_TEXT_TAREA_1
  push __DIR_FISICA_TEXT_TAREA_1
  push __LONGITUD_TEXT_TAREA_1

  call COPY_INIT                        ; Copio el codigo de la tarea_1 a RAM
    
  pop eax
  pop eax
  pop eax


  push __INICIO_ROM_TEXT_TAREA_2
  push __DIR_FISICA_TEXT_TAREA_2
  push __LONGITUD_TEXT_TAREA_2

  call COPY_INIT                        ; Copio el codigo de la tarea_2 a RAM
    
  pop eax
  pop eax
  pop eax


  push  __INICIO_ROM_TSS_TAREA_0
  push __DIR_FISICA_TSS_TAREA_0
  push __LONGITUD_TSS_TAREA_0

  call COPY_INIT                        ; Copio la TSS de tarea_0 a RAM
    
  pop eax
  pop eax
  pop eax


  push  __INICIO_ROM_TSS_TAREA_1
  push __DIR_FISICA_TSS_TAREA_1
  push __LONGITUD_TSS_TAREA_1

  call COPY_INIT                        ; Copio la TSS de tarea_1 a RAM
    
  pop eax
  pop eax
  pop eax



  push __INICIO_ROM_TSS_TAREA_2
  push __DIR_FISICA_TSS_TAREA_2
  push __LONGITUD_TSS_TAREA_2

  call COPY_INIT                        ; Copio la TSS de tarea_2 a RAM
    
  pop eax
  pop eax
  pop eax

;--------------------------------------------------------------------------------------------------------------
BKP


lgdt [cs:img_gdtr_32] 

lidt [img_idtr]

mov ax, tss_32   
ltr ax

call _pic_configure
call _pit_configure

mov esp, __FIN_PILA_NUCLEO_TAREA_0 
mov ebp, __INICIO_PILA_NUCLEO_TAREA_0

BKP
mov eax, __DIR_FISICA_PAGE_TABLES_0   ; La tarea inicial va arrancar en el DIRECTORIO 0
mov cr3,eax                           ; Apuntar a directorio de paginas.
mov eax,cr0                           ; Activar paginacion encendiendo el
or eax,0x80000000                     ; bit 31 de CR0.
mov cr0,eax


mov eax, cr0
and eax, 0xFFFFFFFB					  ; Poner en 0 el bit Emulation para SIMD
or eax, 0x8							  ; Poner en 1 el bit Task Switched para SIMD
mov cr0, eax

mov eax, cr4
or eax, 0x600         				  ; Poner en 1 el bit 9 y 10 para SIMD
mov cr4, eax

sti
jmp TAREA_0





;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

section .datos 
_ENTRADA_TABLA: dq __INICIO_RAM_TABLA_DIGITOS + 0x10 ; Puntero a la primera entrada de tabla libre
_CONTADOR_TAREA_2: dq 0x05


section .bss nobits

_CONTADOR_TECLAS: resq 1         ; Contador de teclas validas presionadas
_CONTADOR_TECLAS_BYTES: resq 1   ; Contador para tomar de a dos hexas, y ponerlos en un byte
_flag_int_teclado: resq 1        ; Flag si interrumpio el teclado
_flag_16_TECLAS: resq 1          ; Flag si se presionaron mas de 16 teclas
_flag_int_timer: resq 1		     ; Flag si interrumpio el timer
_CONTADOR_TIMER: resq 1          ; Contador de interrupciones del PIT cada 10ms
_CONTADOR_TIMER_2: resq 1        ; Contador de interrupciones del PIT cada 100ms
_NUMERO_TOTAL : resq 2           ; Suma total de los numeros cargados en la TABLA_DIGITOS
_FALLO_PAGINA_NUMERO: resq 1     ; Direccion de la pagina que falla CR2
_CONTADOR_PAGINAS_NO_PRESENTES: resq 1 ; Contador de paginas no presentes que ya fueron paginadas
_CONTADOR_TAREA_1: resq 1
_TAREA_ACTUAL: resq 1
_TAREA_FUTURA: resq 1
_CONTADOR_TABLAS_PAGINAS: resq 1 ; Contardor de cantidad de tablas de paginas ya creadas
_BUFFER_NUMERO_PANTALLA: resq 1  ; Numero en ascii a cargar en la seccion de VIDEO

