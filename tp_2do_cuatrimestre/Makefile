NAME = td3_i2c
MOD_NAME = src/td3_i2c
PASSWORD = temppwd
IP = 192.168.6.2

KERNEL_SOURCE := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
INCLUDES := $(shell pwd)/inc

obj-m += $(MOD_NAME).o



.PHONY: all
all: rm_mod compile
	

.PHONY: rm_mod
rm_mod:
	sudo dmesg -c
	sudo rmmod ${NAME}
#	sudo rmmod ${MOD_NAME}.ko


.PHONY: install
install:
	sudo insmod ${MOD_NAME}.ko
	ls -l /dev/ | grep i2c
	lsmod | grep td3_i2c
	dmesg
	@sudo chmod 777 /dev/td3_i2c


.PHONY: compile
compile:
	${MAKE} -C ${KERNEL_SOURCE} SUBDIRS=${PWD} -I${INCLUDES} modules
	sudo insmod ${MOD_NAME}.ko
	ls -l /dev/ | grep i2c
	lsmod | grep td3_i2c
	dmesg
	sudo dmesg -C
	@sudo chmod 777 /dev/td3_i2c


.PHONY: test
test:
	./test/td3_i2c_test


.PHONY: monitor
monitor:
	udevadm trigger
	udevadm monitor --env


.PHONY: clean_mod
clean_mod:
	rm *.ko *.o Module.symvers modules.order *.mod.c
	${MAKE} -C ${KERNEL_SOURCE} SUBDIRS=${PWD} *.c clean


