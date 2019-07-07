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
GLOBAL isr80_handler_SYS_CALL

EXTERN __DIR_FISICA_PAGE_TABLES_0
EXTERN __DIR_FISICA_PAGE_TABLES_1
EXTERN __DIR_FISICA_PAGE_TABLES_2



EXTERN _TSS_0_eax
EXTERN _TSS_0_ebx
EXTERN _TSS_0_ecx
EXTERN _TSS_0_edx
EXTERN _TSS_0_edi
EXTERN _TSS_0_esi
EXTERN _TSS_0_ebp
EXTERN _TSS_0_esp
EXTERN _TSS_0_eip
EXTERN _TSS_0_eflags
EXTERN _TSS_0_cs
EXTERN _TSS_0_ds
EXTERN _TSS_0_es
EXTERN _TSS_0_ss

GLOBAL LECTURA_TECLA
EXTERN __INICIO_RAM_TECLADO_RUTINA
EXTERN MOSTRAR_PANTALLA
EXTERN _FALLO_PAGINA_NUMERO
EXTERN __INICIO_RAM_PAGE_TABLES
EXTERN PAGINACION
EXTERN _CONTADOR_PAGINAS_NO_PRESENTES
EXTERN __DIR_FISICA_PAGINAS_NO_PRESENTES
EXTERN _CONTADOR_TAREA_1
EXTERN _CONTADOR_TAREA_2
EXTERN _CONTADOR_TECLAS
EXTERN _NUMERO_TOTAL
EXTERN _flag_16_TECLAS
EXTERN TAREA_0
EXTERN _TAREA_ACTUAL
EXTERN _TAREA_FUTURA
EXTERN cs_sel_32_usuario
EXTERN COPY_INIT
EXTERN __INICIO_RAM_TABLA_DIGITOS
;-------------------------------------------------------------------------------
%define _PUERTO_TECLADO  0x64;
%define _PUERTO_TECLADO_CODIGO 0x60;

;-------------------------------------------------------------------------------
EXTERN CARGAR_TABLA
EXTERN CARGAR_TABLA_2

GLOBAL _flag_int_teclado
GLOBAL _flag_16_TECLAS
EXTERN BUFFER_DOBLE_OFFS

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
%define _TIEMPO_TAREA_1 5
%define _TIEMPO_TAREA_2 10
%define _OFFSET_TAREAS  3

%define buffer 1
%define num_bytes 1
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
;jc POLLING                             ; Me quedo solo con la tecla persionada

ret



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
   mov edx, 14
   xchg bx,bx
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


;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------

isr32_handler_PIT:

  push eax
  mov al,0x20                          ; Codigo para avisar al PIC que atendi la int 
  out 0x20,al
  mov eax, cr3
  mov [_TAREA_ACTUAL], eax
   

  ;xchg bx, bx
  inc BYTE[_CONTADOR_TAREA_1]
  inc BYTE[_CONTADOR_TAREA_2]

  ;BKP
  cmp BYTE[_CONTADOR_TAREA_1], _TIEMPO_TAREA_1
  mov dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_1
  je VALIDACION_CAMBIO_TAREA

  cmp BYTE[_CONTADOR_TAREA_2], _TIEMPO_TAREA_2
  mov dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_2
  je VALIDACION_CAMBIO_TAREA
  

  mov dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_0
  je VALIDACION_CAMBIO_TAREA

  VALIDACION_CAMBIO_TAREA:
  mov eax, [_TAREA_FUTURA] 
  cmp dword[_TAREA_ACTUAL], eax
  pop eax
  je FIN2
  jmp GUARDAR



  GUARDAR:


   mov dword [_TSS_0_eax], eax 
   mov dword [_TSS_0_ebx], ebx
   mov dword [_TSS_0_ecx], ecx
   mov dword [_TSS_0_edx], edx
   mov dword [_TSS_0_esi], esi
   mov dword [_TSS_0_edi], edi


   pop eax
   mov dword [_TSS_0_eip], eax              ; Guardo EIP de la tarea actual
   pop eax
   mov word [_TSS_0_cs], ax                 ; Guardo CS de la tarea actual
   pop eax
   mov dword [_TSS_0_eflags], eax           ; Guardo EFLAGS de la tarea actua
   mov eax, ds
   mov word [_TSS_0_ds], ax

   mov eax, es
   mov word [_TSS_0_es], ax

   mov dword [_TSS_0_ebp], ebp


   CONSULTAR_GUARDADO_TAREA_USUARIO:

   cmp byte[_TSS_0_cs], cs_sel_32_usuario
   je GUARDADO_PILA

   GUARDADO_REGISTROS:
   mov dword [_TSS_0_esp], esp
   ;mov eax, ss
   ;mov word [_TSS_0_es], ax
   jmp CAMBIO_TAREA_0

   GUARDADO_PILA:
   pop eax
   mov dword [_TSS_0_esp], eax
   pop eax
   mov dword [_TSS_0_ss], eax






   CAMBIO_TAREA_0:
   ;xchg bx, bx
   cmp dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_0
   jne CAMBIO_TAREA_1
   mov eax, [_TAREA_FUTURA]
   mov dword[_TAREA_ACTUAL], eax
   mov cr3, eax
   jmp CONSULTAR_CARGADO_TAREA_USUARIO
   je FIN2


   CAMBIO_TAREA_1:
   ;xchg bx, bx
   cmp dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_1
   jne CAMBIO_TAREA_2
   mov eax, [_TAREA_FUTURA]
   mov dword[_TAREA_ACTUAL], eax
   mov cr3, eax
   mov BYTE[_CONTADOR_TAREA_1], 0x00

   jmp CONSULTAR_CARGADO_TAREA_USUARIO
   je FIN2


   CAMBIO_TAREA_2:
   ;xchg bx, bx
   cmp dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_2 ; Esta comparacion no haria falta, si llega aca
   jne FIN2                                             ; es porque es la tarea 2
   mov eax, [_TAREA_FUTURA]
   mov dword[_TAREA_ACTUAL], eax
   mov cr3, eax
   mov BYTE[_CONTADOR_TAREA_2], _OFFSET_TAREAS

   jmp CONSULTAR_CARGADO_TAREA_USUARIO
   je FIN2


   CONSULTAR_CARGADO_TAREA_USUARIO:
   mov ax, [_TSS_0_cs]
   mov bx, cs
   cmp ax,bx
   jne CARGADO_PILA

   CARGADO_REGISTROS:
   mov esp, dword [_TSS_0_esp]

   jmp CARGANDO

   CARGADO_PILA:
   mov ax, [_TSS_0_ss]
   and eax, 0x0000FFFF
   push eax
   mov eax, [_TSS_0_esp]
   push eax
   jmp CARGANDO



   CARGANDO:
   mov word ax, [_TSS_0_ds]
   mov ds, ax
   mov word ax, [_TSS_0_es]

   mov es, ax

   mov eax, dword [_TSS_0_eax] 
   mov ebx, dword [_TSS_0_ebx]
   mov ecx, dword [_TSS_0_ecx]
   mov edx, dword [_TSS_0_edx]
   mov esi, dword [_TSS_0_esi]
   mov edi, dword [_TSS_0_edi]

   mov ebp, dword [_TSS_0_ebp]

   mov eax, dword [_TSS_0_eflags]          ; Cargo EFLAGS de la tarea actual
   push eax
   mov ax, word [_TSS_0_cs]                ; Cargo CS de la tarea actual
   push eax
   mov eax ,dword [_TSS_0_eip]             ; Cargo EIP de la tarea actual
   push eax




FIN2:
iret

;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------

isr33_handler_KEYBOARD:

   pushad
   mov al,0x20                              ; Codigo para avisar al PIC que atendi la int 
   out 0x20,al


  INT_TECLA:

      call LECTURA_TECLA
      

    T_0:
      cmp al, TECLA_0
      mov bl, 0x0 ; 
      jz GUARDADO_HEXA

    T_1:
      cmp al, TECLA_1
      mov bl, 0x1 ;  ; 
      jz GUARDADO_HEXA

    T_2:
      cmp al, TECLA_2 ; 
      mov bl, 0x2 ; 
      jz GUARDADO_HEXA

    T_3:
      cmp al, TECLA_3 ; 
      mov bl, 0x3
      jz GUARDADO_HEXA   

    T_4:
      cmp al, TECLA_4
      mov bl, 0x4 ; 
      jz GUARDADO_HEXA 

    T_5:
      cmp al, TECLA_5 ; 
      mov bl, 0x5
      jz GUARDADO_HEXA   

    T_6:
      cmp al, TECLA_6
      mov bl, 0x6 ; 
      jz GUARDADO_HEXA   

    T_7:
      cmp al, TECLA_7 ; 
      mov bl, 0x7
      jz GUARDADO_HEXA     
    
    T_8:
      cmp al, TECLA_8
      mov bl, 0x8 ; 
      jz GUARDADO_HEXA
    
    T_9:
      cmp al, TECLA_9 
      mov bl, 0x9 
      jz GUARDADO_HEXA  
    
    T_A:
      cmp al, TECLA_A ; 
      mov bl, 0xA
      jz GUARDADO_HEXA
    
    T_B:
      cmp al, TECLA_B 
      mov bl, 0xB 
      jz GUARDADO_HEXA  
    
    T_C:
      cmp al, TECLA_C ; 
      mov bl, 0xC
      jz GUARDADO_HEXA 
    
    T_D:
      cmp al, TECLA_D 
      mov bl, 0xD
      jz GUARDADO_HEXA 
    
    T_E:
      cmp al, TECLA_E 
      mov bl, 0xE
      jz GUARDADO_HEXA 

    T_F:
      cmp al, TECLA_F 
      mov bl, 0xF
      jz GUARDADO_HEXA 

    T_ENTER:
      cmp al, TECLA_ENTER ; 
      jz FIN


  jmp RESET


    GUARDADO_HEXA:
    push bx
    call CARGAR_TABLA
    pop bx
    jmp RESET


    FIN:
      
      cmp byte[_CONTADOR_TECLAS],0x0    ; Me fijo si estoy parado en la primer pocision del vector
      jz CASO_TECLA_ENTER_SOLA
      JMP CASO_NORMAL


      CASO_TECLA_ENTER_SOLA:
      cmp byte[_flag_16_TECLAS],0x0    ; Me fijo si la cantidad de teclas fue  realmente 0 o multiplo de 16
      jz RESET                         ; Si fue 0, es porque solo se presiono la tecla ENTER

      CASO_NORMAL:
      call CARGAR_TABLA_2
      

 RESET:

 popad
 iret

;/////////////////////////////////////////////////////////////////////////////////////////////////
;-------------------------------------------------------------------------------------------------

isr80_handler_SYS_CALL:
  
    cmp ax, 0x01
    je td3_halt

    cmp ax, 0x02
    je td3_read

    cmp ax, 0x03
    je td3_print

    iret
 ;----------------------------------------------------------------------------------------
    td3_halt:
    sti
    hlt

    iret

;----------------------------------------------------------------------------------------
    td3_read:
   
  	push __INICIO_RAM_TABLA_DIGITOS ; source
  	push ebx						; buffer
  	push ecx    					; num_bytes

  	call COPY_INIT
  
  	pop eax
  	pop eax
  	pop eax

    iret

;----------------------------------------------------------------------------------------
    td3_print:

    push ebx                           ; Guardo el valor de COLUMNAS  
    push ecx                           ; Guardo el valor de FILAS
    push edx
    call MOSTRAR_PANTALLA              ; Muestro en pantalla el numero cada 10 veces que vence 10ms(base de tiempo)
    pop eax
    pop eax
    pop eax

	iret
;----------------------------------------------------------------------------------------