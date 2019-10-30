INPUT = read_test.c
INPUT_2 = write_test.c
OUTPUT = read_test
OUTPUT_2 = write_test

all: clean compile

compile:
	@echo("-----------------------------------------------\n")
	@echo("Compilando\n")
	arm-linux-gnueabihf-gcc $(INPUT) -o $(OUTPUT)
	arm-linux-gnueabihf-gcc $(INPUT_2) -o $(OUTPUT_2)

read:
	./$(OUTPUT)

write:
	./$(OUTPUT_2)

clean:
	@echo("-----------------------------------------------\n")
	@echo("Borrando\n")
	-rm $(INPUT) $(INPUT_2)