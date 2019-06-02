
__INICIO_PILA = 0x1FFFB000;
__SIZE_PILA = 0x4000;
__FIN_PILA = __INICIO_PILA + __SIZE_PILA;


MEMORY
{
	ram (rwx) : ORIGIN = 0x00000000, LENGTH = 0x00300000
	rom_init (rx) : ORIGIN = 0xFFFF0000, LENGTH = 0xFFF0
	rom_reset (rx) : ORIGIN = 0xFFFFFFF0, LENGTH = 0x10  
}


SECTIONS
{
	.init 0xFFFF0000:
	{*(.init)} AT >rom_init		



	.rutinas 0x00000000 :
	{ __INICIO_RAM_RUTINAS  = .;
	  __INICIO_ROM_RUTINAS  = LOADADDR(.rutinas);
	  bin/copy.elf(.copy);
	  *(.rutinas);} AT >rom_init
	  __LONGITUD_RUTINAS = SIZEOF(.rutinas);


	
	.nucleo 0x00300000:
	{ __INICIO_NUCLEO = .;
	  __INICIO_ROM = LOADADDR(.nucleo);
		*(.nucleo);} AT >rom_init
	  __LONGITUD_ROM = SIZEOF(.nucleo);


	
	.reset 0xFFFFFFF0 :
	{*(.reset);}	AT >rom_reset



}
