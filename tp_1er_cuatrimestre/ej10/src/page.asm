GLOBAL PAGINACION_INIT


EXTERN __INICIO_RAM_RUTINAS
EXTERN __INICIO_RAM_NUCLEO
EXTERN __INICIO_RAM_SYS_TABLES
EXTERN __INICIO_RAM_PAGE_TABLES
EXTERN __INICIO_RAM_ISR
EXTERN __INICIO_RAM_TABLA_DIGITOS
EXTERN __INICIO_RAM_TEXT_TAREA_1
EXTERN __INICIO_RAM_DATOS
EXTERN __INICIO_RAM_BSS

EXTERN __INICIO_ROM
EXTERN __LONGITUD_INIT

EXTERN __LONGITUD_ISR
EXTERN __LONGITUD_SYS_TABLES
EXTERN __LONGITUD_PAGE_TABLES
EXTERN __LONGITUD_RUTINAS
EXTERN __LONGITUD_ROM
EXTERN __LONGITUD_DATOS
EXTERN __LONGITUD_BSS
EXTERN __LONGITUD_TEXT_TAREA_1
EXTERN __LONGITUD_TABLA_DIGITOS
EXTERN _BUFFER_VIDEO

EXTERN __SIZE_PILA
EXTERN __INICIO_PILA


;+------------------------------------------------------------------------------------------+
;| Direcciones a paginar        Longitud                                                    |
;|------------------------------------------------------------------------------------------+
;| .ISR0          0x00000000  - 0x0000000c5 ---> 1  PAG  ---> DIR 000  ---> TAB 000         |
;| BUFFER_VIDEO   0x000b8000  - 0x000001000 ---> 1  PAG  ---> DIR 000  ---> TAB 0B8         |
;| .sys_tables    0x00100000  - 0x000000134 ---> 1  PAG  ---> DIR 000  ---> TAB 100         | 
;| .page_tables   0x00110000  - 0x000001000 ---> 1  PAG  ---> DIR 000  ---> TAB 0 -         |
;| .tabla_digitos 0x00310000  - 0x000010000 ---> 16 PAG  ---> DIR 000  ---> TAB 310 - 320   |
;| .nucleo        0x00400000  - 0x000000189 ---> 1  PAG  ---> DIR 001  ---> TAB 000         | 
;| .text_tarea_1  0x00420000  - 0x00000003e ---> 1  PAG  ---> DIR 001  ---> TAB 020         | 
;| .datos         0x004E0000  - 0x000000058 ---> 1  PAG  ---> DIR 001  ---> TAB 0E0         | 
;| .rutinas       0x00F00000  - 0x0000001f4 ---> 1  PAG  ---> DIR 003  ---> TAB 300         |
;|  pila          0x1FFFB000  - 0x000003000 ---> 3  PAG  ---> DIR 07F  ---> TAB 3FB - 3FD   |
;| .rom           0xFFFF0000  - 0x000002000 ---> 2  PAG  ---> DIR 3FF  ---> TAB 3F0 - 3F2   |
;+------------------------------------------------------------------------------------------+


section .rutinas
USE32

  PAGINACION_INIT:
  mov ecx, 0x0
  
  push  ecx  
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_ISR
  push  __INICIO_RAM_ISR
  push  __INICIO_RAM_ISR

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_SYS_TABLES
  push  __INICIO_RAM_SYS_TABLES
  push  __INICIO_RAM_SYS_TABLES

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_ROM
  push  __INICIO_RAM_NUCLEO
  push  __INICIO_RAM_NUCLEO

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx

  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_TEXT_TAREA_1
  push  __INICIO_RAM_TEXT_TAREA_1
  push  __INICIO_RAM_TEXT_TAREA_1

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_DATOS
  push  __INICIO_RAM_DATOS
  push  __INICIO_RAM_DATOS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_BSS
  push  __INICIO_RAM_BSS
  push  __INICIO_RAM_BSS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_RUTINAS
  push  __INICIO_RAM_RUTINAS
  push  __INICIO_RAM_RUTINAS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __LONGITUD_TABLA_DIGITOS
  push  __INICIO_RAM_TABLA_DIGITOS
  push  __INICIO_RAM_TABLA_DIGITOS

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx


  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  0x1000
  push  _BUFFER_VIDEO
  push  _BUFFER_VIDEO

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx



  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  __SIZE_PILA + 0x1000
  push  __INICIO_PILA
  push  __INICIO_PILA

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx



  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
  push  0x03
  push  0x03
  push  0x6000
  push  __INICIO_RAM_PAGE_TABLES
  push  __INICIO_RAM_PAGE_TABLES

  call PAGINACION

  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop eax
  pop ecx



 xchg bx, bx

  push  ecx
  push  __INICIO_RAM_PAGE_TABLES
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
  pop ecx



  ret 


;////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////


PAGINACION:

mov ebp, esp  
mov esi,[ebp + 4]  ; Cargo direccion lineal
mov edi,[ebp + 8]  ; Cargo direccion fisica
mov ecx,[ebp + 12] ; Cargo longitud de la seccion a paginar
mov eax,[ebp + 24] ; Cargo direccion del DIRECTORIO
mov ebx,[ebp + 28] ; Cargo contador de tablas ya paginadas

 
DIRECTORIO:   ;Puntero a tabla:  __INICIO_RAM_PAGE_TABLES + (contador+1) * 0x1000  + ATRIBUTOS_DIRECTORIO
shr esi, 22
and esi, 0x3FF


mov ebx, dword [eax + esi * 4] ; Compruebo si ya existe un valor de tabla para el DIRECTORIO correspondiente
cmp ebx, 0x0
jnz TABLA                      ; Si existe, salto al cargado de entradas de la TABLA de paginas

mov eax,[ebp + 28]        ; Cargo el valor de la ultima TABLA usada
inc eax                   ; Incremento una nueva TABLA
mov [ebp + 28],eax        ; Guardo el valor incrementado en la pila nuevamente

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

