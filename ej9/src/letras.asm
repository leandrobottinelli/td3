; Mostrar en pantalla seis letras de 'A' a 'F' que se muevan por la pantalla.
; Tanto la posición inicial como la velocidad (fija) debe ser aleatoria.
; Al llegar al extremo de la pantalla, la letra debe rebotar.
; El código debe estar en modo protegido con segmentos de 32 bits.

; Hecho por Dario Alpern el 13/04/2018









section .rutinas

;%include "init_pci.inc"


CANT_LETRAS   equ 6
CANT_FILAS    equ 25
COLS_POR_FILA equ 80
MAX_VELOCIDAD equ 64 ;Un cuarto de fila o columna por tick de reloj.      

BUFFER_DOBLE_OFFS EQU 0x20000


inicio:


; El orden queda little-endian para usar menos instrucciones, ya que 
; los procesadores Intel usan little-endian.
OFFS_FILA       EQU 0               ;Fila (fracción, luego entero)
OFFS_COLUMNA    EQU OFFS_FILA+2     ;Columna (fracción, luego entero)
OFFS_DELTAX     EQU OFFS_COLUMNA+2  ;Delta X (fracción, luego entero)
OFFS_DELTAY     EQU OFFS_DELTAX+2   ;Delta Y (fracción, luego entero)
LONG_ESTRUCTURA_POR_LETRA EQU OFFS_DELTAY+2

VARS_LETRAS equ BUFFER_DOBLE_OFFS+2*CANT_FILAS*COLS_POR_FILA
semilla equ VARS_LETRAS+CANT_LETRAS*LONG_ESTRUCTURA_POR_LETRA
FLAG_INT equ semilla + 4
BUFFER_VIDEO equ 0xb8000



     mov [semilla], eax
;Inicializar el array de estructuras correspondiente a cada letra.
     mov ebx, VARS_LETRAS   ;Offset (dirección efectiva) del array.
     mov ecx, CANT_LETRAS   ;Cantidad de elementos del array.
ciclo_init:
     mov esi,CANT_FILAS*256
     ;call nro_aleatorio
     mov [ebx+OFFS_FILA],dx    ;Fracción y entero del número de fila.
     mov esi,COLS_POR_FILA*256
     ;call nro_aleatorio
     mov [ebx+OFFS_COLUMNA],dx ;Fracción y entero del número de columna.
     mov esi,MAX_VELOCIDAD*2
     ;call nro_aleatorio     
     sub edx,MAX_VELOCIDAD     ;Convertir a rango -MAX_VELOCIDAD a MAX_VELOCIDAD
     mov [ebx+OFFS_DELTAX],dx  ;Fracción y entero de la velocidad horizontal.
     mov esi,MAX_VELOCIDAD*2
     ;call nro_aleatorio     
     sub edx,MAX_VELOCIDAD     ;Convertir a rango -MAX_VELOCIDAD a MAX_VELOCIDAD
     mov [ebx+OFFS_DELTAY],dx  ;Fracción y entero de la velocidad vertical.
     
     add ebx,LONG_ESTRUCTURA_POR_LETRA ;Apuntar al siguiente elemento del array.
     loop ciclo_init ;decrementa ecx y salta si no es 0
    ;En instrcucciones de cadena:
    ;Instruccion std -> decrementa puntero (flag dirección <- 1).
    ;Instruccion cld -> incrementa puntero (flag dirección <- 0).
;Programar el timer cero para que interrumpa 18,2 veces por segundo.
     mov al, 0x36              ;Timer counter cero (bits 7-6).
     out 0x43, al
     mov al,0
     out 0x40, al              ;Escribir el byte menos significativo de la cuenta.
     out 0x40, al              ;Escribir el byte más significativo de la cuenta.
     sti                       ;Habilitar interrupciones.

ciclo_mostrar_letras:
;Hallar ubicación de la letra en el buffer doble: 2*(fila*COLS_POR_FILA+columna).
     mov al,COLS_POR_FILA
     mul byte [ebx+OFFS_FILA+1]     ;Producto en AX.
     add al, [ebx+OFFS_COLUMNA+1]   ;Otra posibilidad (movzx dx, byte[ebx+2])
     adc ah, 0                      ;add ax,dx (mov con zero extend)
     movzx eax, ax                  ;Completar producto a 32 bits.
     mov [BUFFER_DOBLE_OFFS+eax*2],dl ;Poner la letra en el buffer doble.
     add ebx,LONG_ESTRUCTURA_POR_LETRA ;Apuntar al siguiente elemento del array.
     inc dl                         ;Indicar siguiente letra (en ASCII).
     loop ciclo_mostrar_letras      ;Cerrar ciclo (decrementar ECX y saltar si no es cero).
;Copiar buffer doble a buffer de video.
     mov esi, BUFFER_DOBLE_OFFS     ;Puntero origen de datos.
     mov edi, BUFFER_VIDEO          ;Puntero destino de datos.
     mov ecx, COLS_POR_FILA*CANT_FILAS 
     rep movsw          ;Operatoria de esta instrcción de cadena:
                        ;WORD [ES:EDI] <- WORD [DS:ESI]
                        ;ESI <- ESI +/- 2 (signo según flag de dirección)
                        ;EDI <- EDI +/- 2 (signo según flag de dirección)
                        ;ECX <- ECX - 1
                        ;Repite instrucción si ECX es distinto de cero.
;Actualizar posición de las letras.
     mov ebx, VARS_LETRAS
     mov ecx, CANT_LETRAS
actualizar_posic_letras:
;Actualizar columna.
     mov ax,[EBX+OFFS_COLUMNA]   ;Obtener columna.
     add ax,[EBX+OFFS_DELTAX]    ;Sumar velocidad horizontal.
     cmp ax,COLS_POR_FILA * 256  ;Verificar si la letra llegó al tope.
     jb guardar_columna          ;Saltar si no es así.
     neg word [EBX+OFFS_DELTAX]  ;Cambiar signo de la velocidad horizontal.
     mov ax,[EBX+OFFS_COLUMNA]   ;Obtener colummna.
     add ax,[EBX+OFFS_DELTAX]    ;Sumar velocidad horizontal.
guardar_columna:
     mov [EBX+OFFS_COLUMNA],ax   ;Guardar columna
;Actualizar fila.
     mov ax,[EBX+OFFS_FILA]      ;Obtener fila.
     add ax,[EBX+OFFS_DELTAY]    ;Sumar velocidad vertical.
     cmp ax,CANT_FILAS * 256     ;Verificar si la letra llegó al tope.
     jb guardar_fila             ;Saltar si no es así.
     neg word [EBX+OFFS_DELTAY]  ;Cambiar signo de la velocidad vertical.
     mov ax,[EBX+OFFS_FILA]      ;Obtener fila.
     add ax,[EBX+OFFS_DELTAY]    ;Sumar velocidad vertical.
guardar_fila:
     mov [EBX+OFFS_FILA],ax      ;Guardar fila.

     add ebx,LONG_ESTRUCTURA_POR_LETRA ;Apuntar al siguiente elemento del array.
     loop actualizar_posic_letras  ;Cerrar ciclo (decrementar ECX y saltar si no es cero).
     
FIN_LOOP:
     xchg bx, bx
     ;cmp byte [FLAG_INT], 1        ;Esperar a que llegue el tick de reloj.
     ;jne FIN_LOOP
     ;mov byte [FLAG_INT], 0        ;Apagar el flag para usarlo en la sig. iteración.

