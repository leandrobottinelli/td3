obj-m :=my_SPI.o
KERNEL_DIR  = /home/leandro/kernel_beagle
PASSWORD =temppwd
IP = 192.168.7.2
PATH_BB = /home/debian/leandro
all:
	@echo '----------------------------------------------------------------------------'
	@echo 'Compiling'
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -C $(KERNEL_DIR) M=$(PWD) modules
	@echo '----------------------------------------------------------------------------'
	@echo 'Copying'
	sshpass -p $(PASSWORD) scp my_SPI.ko debian@$(IP):$(PATH_BB)
	@echo '----------------------------------------------------------------------------'


clean:
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -C $(KERNEL_DIR) M=$(PWD) clean
