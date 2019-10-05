GLOBAL PAGINACION_INIT
GLOBAL PAGINACION
EXTERN _CONTADOR_TABLAS_PAGINAS


EXTERN __INICIO_RAM_RUTINAS
EXTERN __INICIO_RAM_NUCLEO
EXTERN __INICIO_RAM_SYS_TABLES
EXTERN __INICIO_RAM_ISR
EXTERN __INICIO_RAM_TABLA_DIGITOS
EXTERN __INICIO_RAM_TEXT_TAREA_0
EXTERN __INICIO_RAM_TEXT_TAREA_1
EXTERN __INICIO_RAM_TEXT_TAREA_2
EXTERN __INICIO_RAM_DATOS
EXTERN __INICIO_RAM_BSS
EXTERN __INICIO_RAM_TSS_TAREA_0
EXTERN __INICIO_RAM_TSS_TAREA_1
EXTERN __INICIO_RAM_TSS_TAREA_2
EXTERN __INICIO_ROM

EXTERN __DIR_FISICA_PAGE_TABLES_0
EXTERN __DIR_FISICA_PAGE_TABLES_1
EXTERN __DIR_FISICA_PAGE_TABLES_2


EXTERN __DIR_FISICA_ISR            
EXTERN __DIR_FISICA_VIDEO         
EXTERN __DIR_FISICA_SYS_TABLES    
EXTERN __DIR_FISICA_NUCLEO        
EXTERN __DIR_FISICA_TABLA_DIGITOS 
EXTERN __DIR_FISICA_TEXT_TAREA_0  
EXTERN __DIR_FISICA_BSS_TAREA_0  
EXTERN __DIR_FISICA_DATA_TAREA_0 
EXTERN __DIR_FISICA_TSS_TAREA_0 
EXTERN __DIR_FISICA_TEXT_TAREA_1  
EXTERN __DIR_FISICA_BSS_TAREA_1
EXTERN __DIR_FISICA_TSS_TAREA_1   
EXTERN __DIR_FISICA_DATA_TAREA_1  
EXTERN __DIR_FISICA_TEXT_TAREA_2  
EXTERN __DIR_FISICA_BSS_TAREA_2  
EXTERN __DIR_FISICA_DATA_TAREA_2
EXTERN __DIR_FISICA_TSS_TAREA_2  
EXTERN __DIR_FISICA_DATOS         
EXTERN __DIR_FISICA_RUTINAS
EXTERN __DIR_FISICA_BSS       


EXTERN __LONGITUD_ISR
EXTERN __LONGITUD_SYS_TABLES
EXTERN __LONGITUD_PAGE_TABLES
EXTERN __LONGITUD_TABLA_DIGITOS
EXTERN __LONGITUD_TEXT_TAREA_0
EXTERN __LONGITUD_TEXT_TAREA_1
EXTERN __LONGITUD_TEXT_TAREA_2
EXTERN __LONGITUD_DATOS
EXTERN __LONGITUD_BSS
EXTERN __LONGITUD_RUTINAS
EXTERN __LONGITUD_NUCLEO
EXTERN __LONGITUD_INIT
EXTERN __LONGITUD_TSS_TAREA_0
EXTERN __LONGITUD_TSS_TAREA_1
EXTERN __LONGITUD_TSS_TAREA_2

EXTERN __DIR_LINEAL_VIDEO

EXTERN __SIZE_PILA_NUCLEO
EXTERN __INICIO_PILA_NUCLEO

EXTERN __INICIO_PILA_NUCLEO_TAREA_0
EXTERN __INICIO_PILA_USUARIO_TAREA_0
EXTERN __SIZE_PILA_NUCLEO_TAREA_0
EXTERN __SIZE_PILA_USUARIO_TAREA_0
EXTERN __DIR_FISICA_PILA_NUCLEO_TAREA_0
EXTERN __DIR_FISICA_PILA_USUARIO_TAREA_0

EXTERN __INICIO_PILA_NUCLEO_TAREA_1
EXTERN __INICIO_PILA_USUARIO_TAREA_1
EXTERN __SIZE_PILA_NUCLEO_TAREA_1
EXTERN __SIZE_PILA_USUARIO_TAREA_1
EXTERN __DIR_FISICA_PILA_NUCLEO_TAREA_1
EXTERN __DIR_FISICA_PILA_USUARIO_TAREA_1

EXTERN __INICIO_PILA_NUCLEO_TAREA_2
EXTERN __INICIO_PILA_USUARIO_TAREA_2
EXTERN __SIZE_PILA_NUCLEO_TAREA_2
EXTERN __SIZE_PILA_USUARIO_TAREA_2
EXTERN __DIR_FISICA_PILA_NUCLEO_TAREA_2
EXTERN __DIR_FISICA_PILA_USUARIO_TAREA_2

section .rutinas
USE32

  PAGINACION_INIT:
  mov ebp, esp  
 

  PAGINACION_DIRECTORIO_0:

  push __DIR_FISICA_PAGE_TABLES_0
  call PAGINACION_DIRECTORIO_N            ; Paginacion de las paginas de kernel para el directorio 0
  pop eax


  push  __DIR_FISICA_PAGE_TABLES_0
  push  0x03
  push  0x03
  push  __LONGITUD_TEXT_TAREA_0
  push  __DIR_FISICA_TEXT_TAREA_0
  push  __INICIO_RAM_TEXT_TAREA_0

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  push  __DIR_FISICA_PAGE_TABLES_0
  push  0x03
  push  0x03
  push  __SIZE_PILA_NUCLEO_TAREA_0
  push  __DIR_FISICA_PILA_NUCLEO_TAREA_0
  push  __INICIO_PILA_NUCLEO_TAREA_0

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax

  push  __DIR_FISICA_PAGE_TABLES_0
  push  0x03
  push  0x03
  push  __SIZE_PILA_USUARIO_TAREA_0 
  push  __DIR_FISICA_PILA_USUARIO_TAREA_0
  push  __INICIO_PILA_USUARIO_TAREA_0

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  push  __DIR_FISICA_PAGE_TABLES_0
  push  0x03
  push  0x03
  push  __LONGITUD_TSS_TAREA_0 
  push  __DIR_FISICA_TSS_TAREA_0
  push  __INICIO_RAM_TSS_TAREA_0

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax





  PAGINACION_DIRECTORIO_1:

  push __DIR_FISICA_PAGE_TABLES_1
  call PAGINACION_DIRECTORIO_N                    ; Paginacion de las paginas de kernel para el directorio 1
  pop eax

  push  __DIR_FISICA_PAGE_TABLES_1
  push  0x03
  push  0x03
  push  __LONGITUD_TEXT_TAREA_1
  push  __DIR_FISICA_TEXT_TAREA_1
  push  __INICIO_RAM_TEXT_TAREA_1


  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax


  push  __DIR_FISICA_PAGE_TABLES_1
  push  0x03
  push  0x03
  push  __SIZE_PILA_NUCLEO_TAREA_1 
  push  __DIR_FISICA_PILA_NUCLEO_TAREA_1
  push  __INICIO_PILA_NUCLEO_TAREA_1


  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax

  push  __DIR_FISICA_PAGE_TABLES_1
  push  0x03
  push  0x03
  push  __SIZE_PILA_USUARIO_TAREA_1 
  push  __DIR_FISICA_PILA_USUARIO_TAREA_1
  push  __INICIO_PILA_USUARIO_TAREA_1


  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax


  push  __DIR_FISICA_PAGE_TABLES_1
  push  0x03
  push  0x03
  push  __LONGITUD_TSS_TAREA_1 
  push  __DIR_FISICA_TSS_TAREA_1
  push  __INICIO_RAM_TSS_TAREA_1

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax




  PAGINACION_DIRECTORIO_2:

  push __DIR_FISICA_PAGE_TABLES_2
  call PAGINACION_DIRECTORIO_N                            ; Paginacion de las paginas de kernel para el directorio 2
  pop eax

  push  __DIR_FISICA_PAGE_TABLES_2
  push  0x03
  push  0x03
  push  __LONGITUD_TEXT_TAREA_2
  push  __DIR_FISICA_TEXT_TAREA_2
  push  __INICIO_RAM_TEXT_TAREA_2

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax


  push  __DIR_FISICA_PAGE_TABLES_2
  push  0x03
  push  0x03
  push  __SIZE_PILA_NUCLEO_TAREA_2 
  push  __DIR_FISICA_PILA_NUCLEO_TAREA_2
  push  __INICIO_PILA_NUCLEO_TAREA_2

  call PAGINACION
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  push  __DIR_FISICA_PAGE_TABLES_2
  push  0x03
  push  0x03
  push  __SIZE_PILA_USUARIO_TAREA_2 
  push  __DIR_FISICA_PILA_USUARIO_TAREA_2
  push  __INICIO_PILA_USUARIO_TAREA_2

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  

  push  __DIR_FISICA_PAGE_TABLES_2
  push  0x03
  push  0x03
  push  __LONGITUD_TSS_TAREA_2 
  push  __DIR_FISICA_TSS_TAREA_2
  push  __INICIO_RAM_TSS_TAREA_2

  call PAGINACION
  
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax






  ret

;---------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------

  PAGINACION_DIRECTORIO_N:     ; Paginacion de las paginas de kernel para el directorio correspondiente

  mov ebp, esp  

  mov eax, [ebp + 4]           ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_ISR
  push  __DIR_FISICA_ISR
  push  __INICIO_RAM_ISR
  

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  mov ebp, esp  
  mov eax, [ebp + 4]           ; Cargo en eax la direccion del directorio a paginar que esta en la pila
  
  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_SYS_TABLES
  push  __DIR_FISICA_SYS_TABLES
  push  __INICIO_RAM_SYS_TABLES

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  mov ebp, esp  
  mov eax, [ebp + 4]            ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_NUCLEO
  push  __DIR_FISICA_NUCLEO
  push  __INICIO_RAM_NUCLEO

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  mov ebp, esp  
  mov eax, [ebp + 4]             ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_DATOS
  push  __DIR_FISICA_DATOS
  push  __INICIO_RAM_DATOS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  mov ebp, esp  
  mov eax, [ebp + 4]            ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_BSS
  push  __DIR_FISICA_BSS
  push  __INICIO_RAM_BSS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  mov ebp, esp  
  mov eax, [ebp + 4]             ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_RUTINAS
  push  __DIR_FISICA_RUTINAS
  push  __INICIO_RAM_RUTINAS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax

  mov ebp, esp  
  mov eax, [ebp + 4]              ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __LONGITUD_TABLA_DIGITOS
  push  __DIR_FISICA_TABLA_DIGITOS
  push  __INICIO_RAM_TABLA_DIGITOS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax

  mov ebp, esp  
  mov eax, [ebp + 4]               ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  0x1000
  push  __DIR_FISICA_VIDEO
  push  __DIR_LINEAL_VIDEO

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax

  mov ebp, esp  
  mov eax, [ebp + 4]               ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  __SIZE_PILA_NUCLEO 
  push  __INICIO_PILA_NUCLEO
  push  __INICIO_PILA_NUCLEO

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax


  mov ebp, esp  
  mov eax, [ebp + 4]  

  push  eax
  push  0x03
  push  0x03
  push  0xF000                   ; Dejo 15 tablas de paginacion por directorio paginadas
  push  eax
  push  eax

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax

  mov ebp, esp  
  mov eax, [ebp + 4]             ; Cargo en eax la direccion del directorio a paginar que esta en la pila

  push  eax
  push  0x03
  push  0x03
  push  0x2000
  push  0xFFFF0000
  push  0xFFFF0000

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax



  ret 


;////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////


PAGINACION:

mov ebp, esp  
mov esi,[ebp + 4]  ; Cargo direccion lineal
mov edi,[ebp + 8]  ; Cargo direccion fisica
mov edx,[ebp + 16]   
mov ecx,[ebp + 12] ; Cargo longitud de la seccion a paginar
mov eax,[ebp + 24] ; Cargo direccion del DIRECTORIO

 
DIRECTORIO:   ;Puntero a tabla:  __INICIO_RAM_PAGE_TABLES + (contador+1) * 0x1000  + ATRIBUTOS_DIRECTORIO
shr esi, 22
and esi, 0x3FF


mov ebx, dword [eax + esi * 4] ; Compruebo si ya existe un valor de tabla para el DIRECTORIO correspondiente
cmp ebx, 0x0
jnz TABLA                      ; Si existe, salto al cargado de entradas de la TABLA de paginas
;xchg bx ,bx
mov eax,[_CONTADOR_TABLAS_PAGINAS]  ; Cargo el valor de la ultima TABLA usada
inc eax                             ; Incremento una nueva TABLA
mov [_CONTADOR_TABLAS_PAGINAS] ,eax ; Guardo el valor incrementado en la pila nuevamente

mov ebx, eax
mov eax,[ebp + 24]        ; Cargo direccion del DIRECTORIO
shl ebx, 12               ; Multiplico el contador por 0x1000 para apuntar a la TABLA
add ebx, eax              ; Sumo el inicio del DIRECTORIO
mov edx,[ebp + 20]        ; Cargo ATRIBUTOS_DIRECTORIO
add ebx, edx              ; Sumos los ATRIBUTOS_DIRECTORIO

mov dword [eax + esi * 4], ebx ; Guardo el valor de TABLA, en la entrada de DIRECTORIO correspondiente


TABLA:

mov esi,[ebp + 4]        ; Cargo la direccion lineal nuevamente
shr esi, 12              ; Obtengo entrada de tabla de pagina
and esi, 0x3FF

and ebx, 0xFFFFF000      ; Resto los ATRIBUTOS_DIRECTORIO para poder cargarle los de TABLA luego



mov edx,[ebp + 16]       ; Cargo ATRIBUTOS_TABLA         
add edi,edx              ; Sumo los atributos a la direccion lineal

shr ecx, 12              ; Desplazo la cantidad de paginas para tener multiplo de 0x1000
cmp ecx, 0x0             ; Si cargue todas las paginas finalizo la paginacion de esta direccion
jnz CASO_NORMAL
jmp INICIO_TABLA

CASO_NORMAL:
dec ecx                  ; Resto 0x1000 porque la direccion linea arranca en 0
add esi, ecx
shl ecx, 12              ; Multiplico por 0x1000 nuevamente
add edi,ecx              ; Sumo la ultima pagina a la direccion lineal a paginar



INICIO_TABLA:    
mov dword [ebx + esi *4], edi;
cmp ecx, 0x0             ; Si cargue todas las paginas finalizo la paginacion de esta direccion
jz FIN
sub ecx, 0x1000          ; Resto 0x1000 a la cantidad de paginas
sub edi, 0x1000          ; Resto 0x1000 a la direccion lineal para siguiente pagina
dec esi
jmp INICIO_TABLA


FIN:
ret

