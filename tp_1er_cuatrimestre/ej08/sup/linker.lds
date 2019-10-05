
/* SECTIONS:   vma (RAM)
 *    rutina_teclado_isr      0x00000000
 *    sys_tables              0x00100000
 *    nucleo                  0x00300000
 *    tabla_digitos           0x00310000
 *    datos                   0x003E0000
 *	  rutinas 				  0x00F00000 
 *    stack 				  0x1FEFB000
 *    rom_init                0xFFFF0000
 *    reset_vector            0xFFFFFFF0
 */



__INICIO_PILA = 0x1FFFB000;
__SIZE_PILA = 0x4000;
__FIN_PILA = __INICIO_PILA + __SIZE_PILA;


MEMORY
{
	ram (rwx) : ORIGIN = 0x00000000, LENGTH = 0xFFFF0000
	rom_init (rx) : ORIGIN = 0xFFFF0000, LENGTH = 0xFFF0
	rom_reset (rx) : ORIGIN = 0xFFFFFFF0, LENGTH = 0x10  
}


SECTIONS
{
	.init 0xFFFF0000:
	{*(.init)} AT >rom_init		



	.rutina_teclado_isr 0x00000000 :
	{ __INICIO_RAM_TECLADO_RUTINA  = .;
	  __INICIO_ROM_TECLADO_RUTINA  = LOADADDR(.rutina_teclado_isr);
	  *(.rutina_teclado_isr);} AT >rom_init
	  __LONGITUD_TECLADO_RUTINA = SIZEOF(.rutina_teclado_isr);



	.sys_tables 0x00100000 :
	{ __INICIO_RAM_SYS_TABLES  = .;
	  __INICIO_ROM_SYS_TABLES  = LOADADDR(.sys_tables);
	  *(.sys_tables);} AT >rom_init
	  __LONGITUD_SYS_TABLES = SIZEOF(.sys_tables);


	.tabla_digitos 0x00310000:
	{__INICIO_RAM_TABLA_DIGITOS = .;
	 __INICIO_ROM_TABLA_DIGITOS = LOADADDR(.tabla_digitos);
	 *(.Tabla_Digitos)} AT >rom_init	


  	.datos 0x003E0000:
	{__INICIO_RAM_DATOS = .;
	 __INICIO_ROM_DATOS = LOADADDR(.datos);
	 *(.datos);} AT >rom_init
    __LONGITUD_DATOS = SIZEOF(.datos);
		
	
	.nucleo 0x00300000:
	{ __INICIO_RAM_NUCLEO = .;
	  __INICIO_ROM_NUCLEO = LOADADDR(.nucleo);
		*(.nucleo);} AT >rom_init
	  __LONGITUD_ROM = SIZEOF(.nucleo);

  	 .rutinas 0x00F00000 :
	{ __INICIO_RAM_RUTINAS  = .;
	  __INICIO_ROM_RUTINAS  = LOADADDR(.rutinas);
	  bin/copy.elf(.copy);
	  *(.rutinas);} AT >rom_init
	  __LONGITUD_RUTINAS = SIZEOF(.rutinas);

	
	.reset 0xFFFFFFF0 :
	{*(.reset);}	AT >rom_reset



}

