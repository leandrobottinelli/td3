
/* SECTIONS:   vma (RAM)
 *    ISR                     0x00000000
 *    sys_tables              0x00100000
 *    page_tables       	  0x00110000
 *    tabla_digitos           0x00310000
 *    nucleo                  0x00400000
 *    TEXT tarea_1            0x00420000
 *    BSS tarea_1             0x00421000
 *    DATA tarea_1            0x00422000
 *    datos                   0x004E0000
 *	  rutinas 				  0x00F00000 
 *    stack 				  0x1FEFB000
 *    rom_init                0xFFFF0000
 *    reset_vector            0xFFFFFFF0
 */


/* SECTIONS:
+-----+------+------------------------------+----------------+----------------+------------------+-----------+
| RAM | Task |        Memory region         | Output section | Input sections | Physical Address | 4KB pages |
+-----+------+------------------------------+----------------+----------------+------------------+-----------+
| yes |      | ISR                          | isr            | isr            | 0x0000 0000      |       256 |
| yes |      | Tablas de sistema            | systables      | sys_tables     | 0x0010 0000      |        16 |
|     |      |                              |                |                |                  |			 |
|     |      | Tablas de paginacion         | page_tables    |                | 0x0011 0000      |       496 |
|     |      | Tabla de digitos             | tabla_digitos  | tabla_digitos  | 0x0031 0000      |        16 |
| yes |      | Nucleo                       | Nucleo         | 	nucleo        | 0x0040 0000      |        16 |
|     |      |                              |                | 			      |                  |           |
|     |      |                              |                | 			      |                  |			 |
| yes |  1   | TEXT Tarea 1                 | TEXT_task_1    | TEXT_task_1    | 0x0032 0000      |         1 |
|     |  1   | BSS Tarea 1                  |                |                | 0x0032 1000      |         1 |
|     |  1   | DATA Tarea 1                 |                |                | 0x0032 2000      |       190 |
|     |      | Datos                        | DATA           | datos          | 0x003E 0000      |    130075 |
|     |      | Pila                         |                |                | 0x1FFF B000      |         3 |
|     |  1   | Pila Tarea 1                 |                |                | 0x1FFF E000      |         3 |
|     |      |                              |                |                |                  |           |
|     |      | Secuencia inicialización ROM | init_code      | init           | 0xFFFF 0000      |           |
|     |      |                              |                | 		          |                  |           |
|     |      |                              |                | 		          |                  |           |
|     |      |                              |                | 	              |                  |           |
|     |      |                              |                | 				  |                  |           |
|     |      | Vector de reset              | reset  		 | reset          | 0xFFFF FFF0      |           |
+-----+------+------------------------------+----------------+----------------+------------------+-----------+
 */




__INICIO_PILA = 0x1FFFB000;
__SIZE_PILA   = 0x3000;
__FIN_PILA    = __INICIO_PILA + __SIZE_PILA;


__INICIO_PILA_TAREA_1 = 0x1FFFE000;
__SIZE_PILA_TAREA_1   = 0x3000;
__FIN_PILA_TAREA_1    = __INICIO_PILA_TAREA_1 + __SIZE_PILA_TAREA_1;


MEMORY
{
	ram (rwx) : ORIGIN = 0x00000000, LENGTH = 0xFFFF0000
	rom_init (rx) : ORIGIN = 0xFFFF0000, LENGTH = 0xFFF0
	rom_reset (rx) : ORIGIN = 0xFFFFFFF0, LENGTH = 0x10  
}


SECTIONS
{
	.init 0xFFFF0000: 			/*VMA*/
	{*(.init);} AT >rom_init	/*LMA*/	
	  __LONGITUD_INIT = SIZEOF(.init);



	.ISR 0x00000000 :
	{ __INICIO_RAM_ISR  = .;
	  __INICIO_ROM_ISR  = LOADADDR(.ISR);
	  *(.rutina_teclado_isr);} AT >rom_init
	  __LONGITUD_ISR = SIZEOF(.ISR);



	.sys_tables 0x00100000 :
	{ __INICIO_RAM_SYS_TABLES  = .;
	  __INICIO_ROM_SYS_TABLES  = LOADADDR(.sys_tables);
	  *(.sys_tables);} AT >rom_init
	  __LONGITUD_SYS_TABLES = SIZEOF(.sys_tables);

	.page_tables 0x00110000 :
	{ __INICIO_RAM_PAGE_TABLES  = .;
	  __INICIO_ROM_PAGE_TABLES  = LOADADDR(.page_tables);
	  *(.page_tables);} AT >rom_init
	  __LONGITUD_PAGE_TABLES = SIZEOF(.page_tables);


	.tabla_digitos 0x00310000:
	{__INICIO_RAM_TABLA_DIGITOS = .;
	 __INICIO_ROM_TABLA_DIGITOS = LOADADDR(.tabla_digitos);
	 *(.Tabla_Digitos)} AT >rom_init	


	.nucleo 0x00400000:
	{ __INICIO_RAM_NUCLEO = .;
	  __INICIO_ROM_NUCLEO = LOADADDR(.nucleo);
		*(.nucleo);} AT >rom_init
	  __LONGITUD_ROM = SIZEOF(.nucleo);

	.text_tarea_1 0x00420000:
	{__INICIO_RAM_TEXT_TAREA_1 = .;
	 __INICIO_ROM_TEXT_TAREA_1 = LOADADDR(.text_tarea_1);
	 *(.text_tarea_1)} AT >rom_init
	 __LONGITUD_TEXT_TAREA_1 = SIZEOF(.text_tarea_1);

	.bss_tarea_1 0x00421000:
	{__INICIO_RAM_BSS_TAREA_1 = .;
	 __INICIO_ROM_BSS_TAREA_1 = LOADADDR(.bss_tarea_1);
	 *(.bss_tarea_1)} AT >rom_init
	 __LONGITUD_BSS_TAREA_1 = SIZEOF(.bss_tarea_1);	

	.data_tarea_1 0x00422000:
	{__INICIO_RAM_DATA_TAREA_1 = .;
	 __INICIO_ROM_DATA_TAREA_1 = LOADADDR(.data_tarea_1);
	 *(.data_tarea_1)} AT >rom_init
	 __LONGITUD_DATA_TAREA_1 = SIZEOF(.data_tarea_1);		


  	.datos 0x004E0000:
	{__INICIO_RAM_DATOS = .;
	 __INICIO_ROM_DATOS = LOADADDR(.datos);
	 *(.datos);} AT >rom_init
    __LONGITUD_DATOS = SIZEOF(.datos);
		

  	 .rutinas 0x00F00000 :
	{ __INICIO_RAM_RUTINAS  = .;
	  __INICIO_ROM_RUTINAS  = LOADADDR(.rutinas);
	  bin/copy.elf(.copy);
	  *(.rutinas);} AT >rom_init
	  __LONGITUD_RUTINAS = SIZEOF(.rutinas);

	
	.reset 0xFFFFFFF0 :
	{*(.reset);}	AT >rom_reset



}

