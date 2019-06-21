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

;GLOBAL POLLING
GLOBAL LECTURA_TECLA
EXTERN __INICIO_RAM_TECLADO_RUTINA
EXTERN _flag_int_teclado
EXTERN _flag_int_timer
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



isr32_handler_PIT:
   ;xchg bx, bx

  push eax
  mov al,0x20                         ; Codigo para avisar al PIC que atendi la int 
  out 0x20,al
  mov eax, cr3
  mov [_TAREA_ACTUAL], eax
   

   push 0x20                           ; Guardo el valor de COLUMNAS  
   push 0x500                          ; Guardo el valor de FILAS
   push _NUMERO_TOTAL
   ;xchg bx,bx
   call MOSTRAR_PANTALLA               ; Muestro en pantalla el numero cada 10 veces que vence 10ms(base de tiempo)
   pop eax
   pop eax
   pop eax
   
  ; popad
   ;sti
   ;BKP
  ; iret



  ;xchg bx, bx
  inc BYTE[CONTADOR_SCHEDULER]
  ;inc BYTE[CONTADOR_SCHEDULER_2]

  ;BKP
  cmp BYTE[CONTADOR_SCHEDULER], 0x02
  mov dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_1
  je VALIDACION_CAMBIO_TAREA

  cmp BYTE[CONTADOR_SCHEDULER], 0x03
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
   mov eax, ss
   mov word [_TSS_0_es], ax
   mov eax, es
   mov word [_TSS_0_ss], ax

   mov dword [_TSS_0_ebp], ebp
   mov dword [_TSS_0_esp], esp

   CAMBIO_TAREA_0:
   ;xchg bx, bx
   cmp dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_0
   jne CAMBIO_TAREA_1
   mov eax, [_TAREA_FUTURA]
   mov dword[_TAREA_ACTUAL], eax
   mov cr3, eax
   jmp CARGANDO
   je FIN2


   CAMBIO_TAREA_1:
   ;xchg bx, bx
   cmp dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_1
   jne CAMBIO_TAREA_2
   mov eax, [_TAREA_FUTURA]
   mov dword[_TAREA_ACTUAL], eax
   mov cr3, eax
   jmp CARGANDO
   je FIN2


   CAMBIO_TAREA_2:
   ;xchg bx, bx
   cmp dword[_TAREA_FUTURA], __DIR_FISICA_PAGE_TABLES_2 ; Esta comparacion no haria falta, si llega aca
   jne FIN2                                             ; es porque es la tarea 2
   mov eax, [_TAREA_FUTURA]
   mov dword[_TAREA_ACTUAL], eax
   mov cr3, eax
   mov BYTE[CONTADOR_SCHEDULER], 0x00
   jmp CARGANDO
   je FIN2



   CARGANDO:
   mov word ax, [_TSS_0_ds]
   mov ds, ax
   mov word ax, [_TSS_0_es]
   mov ss, ax
   mov word ax, [_TSS_0_ss]
   mov es, ax

   mov eax, dword [_TSS_0_eax] 
   mov ebx, dword [_TSS_0_ebx]
   mov ecx, dword [_TSS_0_ecx]
   mov edx, dword [_TSS_0_edx]
   mov esi, dword [_TSS_0_esi]
   mov edi, dword [_TSS_0_edi]

   mov ebp, dword [_TSS_0_ebp]
   mov esp, dword [_TSS_0_esp]

   mov eax, dword [_TSS_0_eflags]          ; Cargo EFLAGS de la tarea actual
   push eax
   mov ax, word [_TSS_0_cs]                ; Cargo CS de la tarea actual
   push eax
   mov eax ,dword [_TSS_0_eip]             ; Cargo EIP de la tarea actual
   push eax




FIN2:
  ; xchg bx, bx

iret




isr33_handler_KEYBOARD:

   pushad
   ;mov ax, 0x1
   ;mov [_flag_int_teclado],ax                      ; Flag para saber que interrumpio el teclado
   
   mov al,0x20                                     ; Codigo para avisar al PIC que atendi la int 

   out 0x20,al




WHILE:
      
      ;mov ax,[_flag_int_timer]          ; Me fijo si vencio timer
      ;cmp ax, 0x01      
      ;jz Cien_ms

   ;   mov bx, [_flag_int_teclado]       ; Me fijo si hubo tecla
    ;  cmp bx, 0x01
    ;  jz INT_TECLA
    ;  jmp WHILE

  ;Cien_ms:
   ;   mov ax,0x00
    ;  mov [_flag_int_timer], ax         ; Reinicio el flag de timer

     ; mov ax, [_CONTADOR_TIMER]         
     ; cmp ax, 0x0A                      ; Me fijo si el timer vencio 10 veces 
     ; jz VENCE_TIMER

      ; mov eax,[_CONTADOR_TIMER]         ; Guardo cada 10 veces la base de tiempo
      ; inc eax 
      ; mov [_CONTADOR_TIMER], eax
      ; jmp WHILE

  ;VENCE_TIMER:

   ; mov ax, 0x0
   ; mov [_CONTADOR_TIMER], ax
    
   ; mov eax,[_CONTADOR_TIMER_2]
   ; inc eax
   ; mov [_CONTADOR_TIMER_2], eax

   ; push 0x20                           ; Guardo el valor de COLUMNAS  
   ; push 0x500                          ; Guardo el valor de FILAS
   ; push _NUMERO_TOTAL
   ; call MOSTRAR_PANTALLA               ; Muestro en pantalla el numero cada 10 veces que vence 10ms(base de tiempo)
   ; pop eax
   ; pop eax
    ;pop eax

    
    ;JMP WHILE


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


  jmp SIGUIENTE


    GUARDADO_HEXA:
    ;BKP
    push bx
    call CARGAR_TABLA
    pop bx
    jmp SIGUIENTE

    SIGUIENTE:
  ; BKP

;      mov ax, 0x0
;      mov [_flag_int_teclado], ax
;      sti
    jmp RESET





    FIN:
      
      cmp byte[_CONTADOR_TECLAS],0x0  ;Me fijo si estoy parado en la primer pocision del vector
      jz CASO_TECLA_ENTER_SOLA
      JMP CASO_NORMAL


      CASO_TECLA_ENTER_SOLA:
      cmp byte[_flag_16_TECLAS],0x0    ;Me fijo si la cantidad de teclas fue  realmente 0 o multiplo de 16
      jz RESET                         ;Si fue 0, es porque solo se presiono la tecla ENTER

      CASO_NORMAL:
      BKP
      call CARGAR_TABLA_2
      
      ;mov [_NUMERO_TOTAL], eax
      ;call TAREA_0

      RESET:
     ; mov ax, 0x0
     ; mov [_flag_int_teclado], ax     ;Reinicio flag de teclado 
     ; sti                             ;Habilito interrupciones nuevamente



popad
;sti
;BKP
iret

CONTADOR_SCHEDULER: resq 1
_TAREA_ACTUAL: resq 1
_TAREA_FUTURA: resq 1











