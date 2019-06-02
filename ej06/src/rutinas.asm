GLOBAL CARGAR_TABLA

EXTERN _CONTADOR_TABLA


section .rutinas
USE32


CARGAR_TABLA:

    mov ebp, esp  
    mov al, [ebp + 4]
    mov ecx, [_CONTADOR_TABLA]     ;Cargo valor del contador en .datos
    mov [ecx], al                  ;Guardo la tecla, en la pocision de memoria
                                   ; de la tabla, indicada por el contador
    inc ecx
    mov [_CONTADOR_TABLA], ecx     ;Guardo el valor del contador incrementado
    ret                            ;para apiuntar al siguiente digito de la tabla


