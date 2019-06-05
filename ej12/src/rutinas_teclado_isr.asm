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
GLOBAL isr32_handler_PIT
GLOBAL isr33_handler_KEYBOARD



;GLOBAL POLLING
GLOBAL LECTURA_TECLA
EXTERN FIN
EXTERN __INICIO_RAM_TECLADO_RUTINA
EXTERN _flag_int_teclado
EXTERN _flag_int_timer
EXTERN MOSTRAR_PANTALLA
EXTERN _FALLO_PAGINA_NUMERO
EXTERN __INICIO_RAM_PAGE_TABLES
EXTERN PAGINACION
EXTERN _CONTADOR_PAGINAS_NO_PRESENTES
EXTERN __DIR_FISICA_PAGINAS_NO_PRESENTES

%define _PUERTO_TECLADO  0x64;
%define _PUERTO_TECLADO_CODIGO 0x60;

;-------------------------------------------------------------------------------

section .rutina_lectura_teclado
USE32

POLLING:

in al, _PUERTO_TECLADO 
bt eax, 0x00
jnc POLLING

LECTURA_TECLA:

in al, _PUERTO_TECLADO_CODIGO
bt ax, 0x7                             ; Me fijo si la tecla fue presionada o soltada
jc POLLING                             ; Me quedo solo con la tecla persionada

;xchg bx,bx
ret


;jmp CARGADO_TABLA


;CARGADO_TABLA:

;push ax
;call CARGAR_TABLA
;pop ax
;ret


;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

section .rutinas_isr
USE32

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

   pushad
 
   mov dx, [esp + 32]             ; Copio de la pila el codigo de error de pagina
   cmp dx, 0x0                    ; Comparo contra cero, supervisor trato de leer pagina no presente
   jnz PRESENTE                   ; En los demas casos, salto la paginacion


   mov edx, 14
   mov eax,cr2                    ; Guardo el numero de la pagina que fallo
   mov [_FALLO_PAGINA_NUMERO],eax ; Guardo el numero de la pagina que fallo en memoria para mostrarlo en pantalla

   push 0x60                      ; Guardo el valor de COLUMNAS  
   push 0x500                     ; Guardo el valor de FILAS
   push _FALLO_PAGINA_NUMERO      ; Guardo el numero de la pagina que fallo
   call MOSTRAR_PANTALLA           
   pop eax
   pop eax
   pop eax


   mov eax,cr2                    ; Miro que pagina fallo
   invlpg [eax]                   ; Invalido la pagina que fallo antes de regresar


   mov ebx, __DIR_FISICA_PAGINAS_NO_PRESENTES ; Cargo la direccion donde voy a paginar las paginas no paginadas
   mov ecx,[ _CONTADOR_PAGINAS_NO_PRESENTES]  ; Cargo valor del contador de las paginas no presentes, ya paginadas anteriormente 
   shl ecx, 12                                ; Multiplico por 0x1000 el contador 
   add ebx, ecx                               ; A la direccion fisica de base, le agrego un multiplo de 0x1000
                                              ; para la nueva direccion fisica, de la pagina no presente a paginar


   push  __INICIO_RAM_PAGE_TABLES
   push  0x03
   push  0x03
   push  0x1000
   push  ebx                                  ; Direccion fisca que propone la guia a partir de 0x08000000 
   push  eax                                  ; Direccion lineal que fallo y quiero paginar

   call PAGINACION

   pop eax
   pop eax
   pop eax
   pop eax
   pop eax
   pop eax

   inc dword[ _CONTADOR_PAGINAS_NO_PRESENTES] ; Incremento contador para que las paginas queden cada 0x1000

   PRESENTE:
   popad
   
   add esp, 4                                 ; Sacar codigo de excepccion de la pila 
   iret



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



isr32_handler_PIT:
   pushad
   mov eax, 0x01
   mov [_flag_int_timer], eax
   mov al,0x20                                     ; Codigo para avisar al PIC que atendi la int 
   out 0x20,al
   popad
   iret
isr33_handler_KEYBOARD:

   pushad
   mov ax, 0x1
   mov [_flag_int_teclado],ax                      ; Flag para saber que interrumpio el teclado
   mov al,0x20                                     ; Codigo para avisar al PIC que atendi la int 
   out 0x20,al
   popad
   iret






















