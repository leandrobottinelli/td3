
OUTPUT_NAME = bios
OUTPUT_NAME2 = copy
OUTPUT_NAME3 = rutinas_teclado_isr
OUTPUT_NAME4 = rutinas
OUTPUT_NAME5 = sys_tables
OUTPUT_NAME6 = pic
OUTPUT_NAME7 = pit

# Compilador
COMPILER = nasm

# LINKER
LINKER = ld

all: clean crear_estructura
	@echo	''
	@echo	'-----> Compilando'
	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME).elf -l bin/$(OUTPUT_NAME).lst src/$(OUTPUT_NAME).asm

	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME2).elf -l bin/$(OUTPUT_NAME2).lst src/$(OUTPUT_NAME2).asm

	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME3).elf -l bin/$(OUTPUT_NAME3).lst src/$(OUTPUT_NAME3).asm

	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME4).elf -l bin/$(OUTPUT_NAME4).lst src/$(OUTPUT_NAME4).asm

	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME5).elf -l bin/$(OUTPUT_NAME5).lst src/$(OUTPUT_NAME5).asm

	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME6).elf -l bin/$(OUTPUT_NAME6).lst src/$(OUTPUT_NAME6).asm

	$(COMPILER) -f elf32 -o bin/$(OUTPUT_NAME7).elf -l bin/$(OUTPUT_NAME7).lst src/$(OUTPUT_NAME7).asm


	@echo	''
	@echo	'-----> Linkeando'
	
	$(LINKER) -z max-page-size=0x1000 -m elf_i386 -T sup/linker.lds  bin/$(OUTPUT_NAME).elf  bin/$(OUTPUT_NAME2).elf bin/$(OUTPUT_NAME3).elf bin/$(OUTPUT_NAME4).elf bin/$(OUTPUT_NAME5).elf bin/$(OUTPUT_NAME6).elf bin/$(OUTPUT_NAME7).elf -o bin/rom.elf  -Map sup/$(OUTPUT_NAME).map

	$(LINKER) -z max-page-size=0x1000 --oformat=binary -m elf_i386 -T sup/linker.lds  bin/$(OUTPUT_NAME).elf bin/$(OUTPUT_NAME2).elf bin/$(OUTPUT_NAME3).elf bin/$(OUTPUT_NAME4).elf  bin/$(OUTPUT_NAME5).elf bin/$(OUTPUT_NAME6).elf bin/$(OUTPUT_NAME7).elf -o bin/rom.bin


bochs:
	@echo	''
	bochs -qf sup/bochs.cfg
	rm *.log
	rm none

map:
	subl sup/$(OUTPUT_NAME).map

crear_estructura:
	mkdir -p bin/ doc/ inc/ lib/ src/ sup/


crear_estructura_init:
	mkdir -p bin/ doc/ inc/ lib/ src/ sup/
	cp /home/leandro/Documentos/TD3/bochs.cfg


clean:
	@echo	''
	@echo	'-----> Limpiando'

	rm -f *.o 
	rm -f ./$(CARPETA_BIN)/*.bin
	rm -f ./$(CARPETA_ELF)/*.elf
	rm -f ./$(CARPETA_OBJ)/*.o
	rm -f ./$(CARPETA_TXT)/*.txt
	rm -f ./$(CARPETA_LST)/*.lst
	rm -f ./$(CARPETA_BIN)/*.log
	rm -f ./$(CARPETA_BIN)/*.ini
	@echo	'------------------'
