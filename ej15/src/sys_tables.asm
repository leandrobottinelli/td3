

GLOBAL img_gdtr_32
GLOBAL img_idtr

GLOBAL cs_sel_32_nucleo
GLOBAL ds_sel_32_nucleo
GLOBAL cs_sel_32_usuario
GLOBAL ds_sel_32_usuario
GLOBAL tss_32

EXTERN isr0_handler_DE
EXTERN isr2_handler_NMI
EXTERN isr3_handler_BP
EXTERN isr4_handler_OF
EXTERN isr5_handler_BR
EXTERN isr6_handler_UD
EXTERN isr7_handler_NM
EXTERN isr8_handler_DF
EXTERN isr9_handler
EXTERN isr10_handler_TS
EXTERN isr11_handler_NP
EXTERN isr12_handler_SS
EXTERN isr13_handler_GP
EXTERN isr14_handler_PF
EXTERN isr15_handler
EXTERN isr16_handler_MF
EXTERN isr17_handler_AC
EXTERN isr18_handler_MC
EXTERN isr19_handler_XF
EXTERN isr20_31_handler
EXTERN isr32_handler_PIT
EXTERN isr33_handler_KEYBOARD
EXTERN isr80_handler_SYS_CALL

section .sys_tables

USE32

gdt_32:
          db 0,0,0,0,0,0,0,0                       ; Descriptor nulo
ds_sel_32_nucleo equ $-gdt_32
          db 0xFF, 0xFF, 0, 0, 0, 0x92, 0xCF, 0    
cs_sel_32_nucleo  equ $-gdt_32
          db 0xFF, 0xFF, 0, 0, 0, 0x9A, 0xCF, 0

ds_sel_32_usuario equ $-gdt_32 + 0x3
          db 0xFF, 0xFF, 0, 0, 0, 0xF2, 0xCF, 0
cs_sel_32_usuario equ $-gdt_32 + 0x3
          db 0xFF, 0xFF, 0, 0, 0, 0xFA, 0xCF, 0

tss_32    equ $-gdt_32
          db 0x68, 0x00, 0, 0, 0x62, 0x89, 0xC0, 0  ; TSS lineal 0x00620000
                                                  ; 0x89 = Presente, descriptor de sistema y 32bit TSS available
                                                  ; 0x68 = Tss Intel template
                                                  ; 0xC0 = 
long_gdt_32 equ $-gdt_32


img_gdtr_32:
    dw long_gdt_32-1
    dd gdt_32



idt:

ISR0 equ $-idt
   dw isr0_handler_DE
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8E
   dw 0x0
   
ISR1 equ $-idt
   dq 0x0

ISR2 equ $-idt
   dw isr2_handler_NMI
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F  
   dw 0x0

ISR3 equ $-idt
   dw isr3_handler_BP
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR4 equ $-idt
   dw isr4_handler_OF
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR5 equ $-idt
   dw isr5_handler_BR
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR6 equ $-idt
   dw isr6_handler_UD
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR7 equ $-idt
   dw isr7_handler_NM
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR8 equ $-idt
   dw isr8_handler_DF
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR9 equ $-idt
   dw isr9_handler
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR10 equ $-idt
   dw isr10_handler_TS
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR11 equ $-idt
   dw isr11_handler_NP
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR12 equ $-idt
   dw isr12_handler_SS
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR13 equ $-idt
   dw isr13_handler_GP
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR14 equ $-idt
   dw isr14_handler_PF
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR15 equ $-idt
   dq 0x0

ISR16 equ $-idt
   dw isr16_handler_MF
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR17 equ $-idt
   dw isr17_handler_AC
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR18 equ $-idt
   dw isr18_handler_MC
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR19 equ $-idt
   dw isr19_handler_XF
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8F
   dw 0x0

ISR20_31 equ $-idt
  times 12 dq 0x0

ISR32 equ $-idt
   dw isr32_handler_PIT
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8E
   dw 0x0

ISR33 equ $-idt
   dw isr33_handler_KEYBOARD
   dw cs_sel_32_nucleo
   db 0x0
   db 0x8E
   dw 0x0

ISR34_ISR79 equ $-idt
  times 94 dq 0x0

ISR80 equ $-idt
   dw isr80_handler_SYS_CALL
   dw cs_sel_32_nucleo
   db 0x0
   db 0xEE
   dw 0x0



long_idt equ $-idt


img_idtr:
      dw long_idt -1
      dd idt

