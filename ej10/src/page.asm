GLOBAL PAGE_PARAMETERS
GLOBAL AA


section .page
USE32

PAGE_PARAMETERS:

    mov ebp, esp  
    mov eax,[ebp + 4]        ;
    mov ebx,[ebp + 8]          
    mov edx,[ebp + 12]         
    mov ecx,[ebp + 16] 
    mov edx,[ebp + 20] 
AA:
    
    eax 
    ret


  ;CALCULAR PAGINAS
  ;CALCULAR DIR       ; NECESITO DIRECCION LINEAL Y FISICA, INICIO DE DIRECTORIO ,ATIRBUTOS TABLA Y DIRECTORIO  
  ;CALCULAR TABLAS

