
/* SECTIONS:   	NOTA: Tabla de digitos cambiado a 0x00310000 respecto a la guia
					  TEXT Tarea 0     cambiado a 0x00510000 respecto a la guia
					  BSS Tarea 0      cambiado a 0x00511000 respecto a la guia
					  DATA Tarea 0     cambiado a 0x00512000 respecto a la guia
					  TEXT Tarea 1     cambiado a 0x00520000 respecto a la guia
					  BSS Tarea 1      cambiado a 0x00521000 respecto a la guia
					  DATA Tarea 1     cambiado a 0x00522000 respecto a la guia
					  TEXT Tarea 2     cambiado a 0x00530000 respecto a la guia
					  BSS Tarea 2      cambiado a 0x00531000 respecto a la guia
					  DATA Tarea 2     cambiado a 0x00532000 respecto a la guia
Elegida Opcion B)					
		
+-----+------+------------------------------+----------------+----------------+------------------+------------------+-----------+
| RAM | Task |        Memory region         | Output section | Input sections | Physical Address | 4KB pages |  Logic Address   |
+-----+------+------------------------------+----------------+----------------+------------------+------------------+-----------+
| yes |      | ISR                          | isr            | rutina_lectura | 0x0000 0000      |           | 0x0000 0000		|
|	  |      |                              |                | rutinas_isr    |                  |           |					|
|     |      | VIDEO                        |                |                | 0x000B 8000      |           | 0x0001 0000   	|
| yes |      | Tablas de sistema            | systables      | sys_tables     | 0x0010 0000      |           | 0x0010 0000 		|
|     |      |                              |                |                |                  |			 |					|
|     |      | Tablas de paginacion         | page_tables    |                | 0x0011 0000      |           | 0x0011 0000  	|
|     |      | Tabla de digitos             | tabla_digitos  | 				  | 0x0031 0000      |           | 0x0031 0000		|
| yes |      | Nucleo                       | Nucleo         | 	nucleo        | 0x0040 0000      |           | 0x0040 0000  	|
|     |      |                              |                | 			      |                  |           |					|
|     |      |                              |                | 			      |                  |			 |					|
| yes |  1   | TEXT Tarea 1                 | TEXT_task_1    | TEXT_task_1    | 0x0042 0000      |           | 0x0052 0000    	|
|     |  1   | BSS Tarea 1                  |                |                | 0x0042 1000      |           | 0x0052 1000   	|
|     |  1   | DATA Tarea 1                 |                |                | 0x0042 2000      |           | 0x0052 2000   	|
|     |      | Datos                        | DATA           | datos          | 0x004E 0000      |           | 0x005E 0000   	|
|     |      | BSS                          | BSS            | BSS            | 0x004F 0000      |           | 0x005F 0000   	|
|     |      | Pila                         |                |                | 0x1FFF B000      |           | 0x1FFF B000   	|
|     |  1   | Pila Tarea 1                 |                |                | 0x1FFF E000      |           | 0x0041 3000    	|
|     |      |                              |                |                |                  |           |					|
|     |      | Secuencia inicialización ROM | init_code      | init           | 0xFFFF 0000      |           | 0xFFFF 0000  	|
|     |      |                              |                | 		          |                  |           |					|
|     |      |                              |                | 		          |                  |           |					|
|     |      |                              |                | 	              |                  |           |					|
|     |      |                              |                | 				  |                  |           |					|
|     |      | Vector de reset              | reset  		 | reset          | 0xFFFF FFF0      |           |					|
+-----+------+------------------------------+----------------+----------------+------------------+------------------------------+
*/


__DIR_FISICA_ISR           			= 0x00000000; 
__DIR_FISICA_VIDEO         			= 0x000B8000;
__DIR_FISICA_SYS_TABLES    			= 0x00100000;
__DIR_FISICA_PAGE_TABLES_0 			= 0x00110000;
__DIR_FISICA_PAGE_TABLES_1 			= 0x00120000;
__DIR_FISICA_PAGE_TABLES_2 			= 0x00130000; 
__DIR_FISICA_TABLA_DIGITOS 			= 0x00310000;
__DIR_FISICA_NUCLEO        			= 0x00500000;
__DIR_FISICA_TEXT_TAREA_0  			= 0x00510000;
__DIR_FISICA_BSS_TAREA_0 			= 0x00511000;
__DIR_FISICA_DATA_TAREA_0  			= 0x00512000;
__DIR_FISICA_TEXT_TAREA_1  			= 0x00520000;
__DIR_FISICA_BSS_TAREA_1  			= 0x00521000;
__DIR_FISICA_DATA_TAREA_1  			= 0x00522000;
__DIR_FISICA_TEXT_TAREA_2  			= 0x00530000;
__DIR_FISICA_BSS_TAREA_2  			= 0x00531000;
__DIR_FISICA_DATA_TAREA_2  			= 0x00532000;
__DIR_FISICA_DATOS         			= 0x005E0000;

__DIR_FISICA_BSS         			= 0x005F0000;
__DIR_FISICA_RUTINAS       			= 0x00F00000;
__DIR_FISICA_PAGINAS_NO_PRESENTES   = 0x08000000;
__DIR_FISICA_TSS_TAREA_0 		    = 0x00513000;
__DIR_FISICA_TSS_TAREA_1   		    = 0x00523000;
__DIR_FISICA_TSS_TAREA_2		    = 0x00533000;



__LONGITUD_TABLA_DIGITOS = 0x10000;
__DIR_LINEAL_VIDEO       = 0x00010000;

/*PILAS NUCLEOS*/

__INICIO_PILA_NUCLEO = 0x1FFFB000;
__SIZE_PILA_NUCLEO   = 0x1000;
__FIN_PILA_NUCLEO    = __INICIO_PILA_NUCLEO + __SIZE_PILA_NUCLEO;


__INICIO_PILA_NUCLEO_TAREA_0 = 0x00614000;
__SIZE_PILA_NUCLEO_TAREA_0   = 0x1000;
__FIN_PILA_NUCLEO_TAREA_0    = __INICIO_PILA_NUCLEO_TAREA_0 + __SIZE_PILA_NUCLEO_TAREA_0;
__DIR_FISICA_PILA_NUCLEO_TAREA_0 = 0x1FFF8000;

__INICIO_PILA_NUCLEO_TAREA_1 = 0x00614000;
__SIZE_PILA_NUCLEO_TAREA_1   = 0x1000;
__FIN_PILA_NUCLEO_TAREA_1    = __INICIO_PILA_NUCLEO_TAREA_1 + __SIZE_PILA_NUCLEO_TAREA_1;
__DIR_FISICA_PILA_NUCLEO_TAREA_1 = 0x1FFF9000;

__INICIO_PILA_NUCLEO_TAREA_2 = 0x00614000;
__SIZE_PILA_NUCLEO_TAREA_2   = 0x1000;
__FIN_PILA_NUCLEO_TAREA_2    = __INICIO_PILA_NUCLEO_TAREA_2 + __SIZE_PILA_NUCLEO_TAREA_2;
__DIR_FISICA_PILA_NUCLEO_TAREA_2 = 0x1FFFA000;

/*PILAS USUARIO*/
__INICIO_PILA_USUARIO_TAREA_0 = 0x00613000;
__SIZE_PILA_USUARIO_TAREA_0   = 0x1000;
__FIN_PILA_USUARIO_TAREA_0    = __INICIO_PILA_USUARIO_TAREA_0 + __SIZE_PILA_USUARIO_TAREA_0;
__DIR_FISICA_PILA_USUARIO_TAREA_0 = 0x1FFFC000;

__INICIO_PILA_USUARIO_TAREA_1 = 0x00613000;
__SIZE_PILA_USUARIO_TAREA_1   = 0x1000;
__FIN_PILA_USUARIO_TAREA_1    = __INICIO_PILA_USUARIO_TAREA_1 + __SIZE_PILA_USUARIO_TAREA_1;
__DIR_FISICA_PILA_USUARIO_TAREA_1 = 0x1FFFD000;

__INICIO_PILA_USUARIO_TAREA_2 = 0x00613000;
__SIZE_PILA_USUARIO_TAREA_2   = 0x1000;
__FIN_PILA_USUARIO_TAREA_2    = __INICIO_PILA_USUARIO_TAREA_2 + __SIZE_PILA_USUARIO_TAREA_2;
__DIR_FISICA_PILA_USUARIO_TAREA_2 = 0x1FFFE000;



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
	  *(.rutinas_isr);
	  *(.rutina_lectura_teclado);} AT >rom_init
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


	.nucleo 0x00500000:
	{ __INICIO_RAM_NUCLEO = .;
	  __INICIO_ROM_NUCLEO = LOADADDR(.nucleo);
		*(.nucleo);} AT >rom_init
	  __LONGITUD_NUCLEO = SIZEOF(.nucleo);

	.text_tarea_0 0x00610000:
	{__INICIO_RAM_TEXT_TAREA_0 = .;
	 __INICIO_ROM_TEXT_TAREA_0 = LOADADDR(.text_tarea_0);
	 *(.text_tarea_0)} AT >rom_init
	 __LONGITUD_TEXT_TAREA_0 = SIZEOF(.text_tarea_0);

	.bss_tarea_0 0x00611000:
	{__INICIO_RAM_BSS_TAREA_0 = .;
	 __INICIO_ROM_BSS_TAREA_0 = LOADADDR(.bss_tarea_0);
	 *(.bss_tarea_0)} AT >rom_init
	 __LONGITUD_BSS_TAREA_0 = SIZEOF(.bss_tarea_0);	

	.data_tarea_0 0x00612000:
	{__INICIO_RAM_DATA_TAREA_0 = .;
	 __INICIO_ROM_DATA_TAREA_0 = LOADADDR(.data_tarea_0);
	 *(.data_tarea_0)} AT >rom_init
	 __LONGITUD_DATA_TAREA_0 = SIZEOF(.data_tarea_0);

	 .text_tarea_1 0x00610000:
	{__INICIO_RAM_TEXT_TAREA_1 = .;
	 __INICIO_ROM_TEXT_TAREA_1 = LOADADDR(.text_tarea_1);
	 *(.text_tarea_1)} AT >rom_init
	 __LONGITUD_TEXT_TAREA_1 = SIZEOF(.text_tarea_1);

	.bss_tarea_1 0x00611000:
	{__INICIO_RAM_BSS_TAREA_1 = .;
	 __INICIO_ROM_BSS_TAREA_1 = LOADADDR(.bss_tarea_1);
	 *(.bss_tarea_1)} AT >rom_init
	 __LONGITUD_BSS_TAREA_1 = SIZEOF(.bss_tarea_1);	

	.data_tarea_1 0x00612000:
	{__INICIO_RAM_DATA_TAREA_1 = .;
	 __INICIO_ROM_DATA_TAREA_1 = LOADADDR(.data_tarea_1);
	 *(.data_tarea_1)} AT >rom_init
	 __LONGITUD_DATA_TAREA_1 = SIZEOF(.data_tarea_1);		

	 .text_tarea_2 0x00610000:
	{__INICIO_RAM_TEXT_TAREA_2 = .;
	 __INICIO_ROM_TEXT_TAREA_2 = LOADADDR(.text_tarea_2);
	 *(.text_tarea_2)} AT >rom_init
	 __LONGITUD_TEXT_TAREA_2 = SIZEOF(.text_tarea_2);

	.bss_tarea_2 0x00611000:
	{__INICIO_RAM_BSS_TAREA_2 = .;
	 __INICIO_ROM_BSS_TAREA_2 = LOADADDR(.bss_tarea_2);
	 *(.bss_tarea_2)} AT >rom_init
	 __LONGITUD_BSS_TAREA_2 = SIZEOF(.bss_tarea_2);	

	.data_tarea_2 0x00612000:
	{__INICIO_RAM_DATA_TAREA_2 = .;
	 __INICIO_ROM_DATA_TAREA_2 = LOADADDR(.data_tarea_2);
	 *(.data_tarea_2)} AT >rom_init
	 __LONGITUD_DATA_TAREA_2 = SIZEOF(.data_tarea_2);

	 .TSS_TAREA_0 0x00620000:
	{__INICIO_RAM_TSS_TAREA_0 = .;
	 __INICIO_ROM_TSS_TAREA_0 = LOADADDR(.TSS_TAREA_0);
	 *(.tss_tarea_0)} AT >rom_init
	 __LONGITUD_TSS_TAREA_0 = SIZEOF(.TSS_TAREA_0);

	.TSS_TAREA_1 0x00620000:
	{__INICIO_RAM_TSS_TAREA_1 = .;
	 __INICIO_ROM_TSS_TAREA_1 = LOADADDR(.TSS_TAREA_1);
	 *(.tss_tarea_1)} AT >rom_init
	 __LONGITUD_TSS_TAREA_1 = SIZEOF(.TSS_TAREA_1);	

	 .TSS_TAREA_2 0x00620000:
	{__INICIO_RAM_TSS_TAREA_2 = .;
	 __INICIO_ROM_TSS_TAREA_2 = LOADADDR(.TSS_TAREA_2);
	 *(.tss_tarea_2)} AT >rom_init
	 __LONGITUD_TSS_TAREA_2 = SIZEOF(.TSS_TAREA_2);							


  	.datos 0x005E0000:
	{__INICIO_RAM_DATOS = .;
	 __INICIO_ROM_DATOS = LOADADDR(.datos);
	 *(.datos);} AT >rom_init
    __LONGITUD_DATOS = SIZEOF(.datos);

    .bss 0x005F0000:
	{__INICIO_RAM_BSS = .;
	 __INICIO_ROM_BSS = LOADADDR(.bss);
	 *(.bss);} AT >rom_init
    __LONGITUD_BSS = SIZEOF(.bss);


		

  	 .rutinas 0x00F00000 :
	{ __INICIO_RAM_RUTINAS  = .;
	  __INICIO_ROM_RUTINAS  = LOADADDR(.rutinas);
	  bin/copy.elf(.copy);
	  *(.rutinas);} AT >rom_init
	  __LONGITUD_RUTINAS = SIZEOF(.rutinas);

	
	.reset 0xFFFFFFF0 :
	{*(.reset);}	AT >rom_reset



}

