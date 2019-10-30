#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/err.h>
#include <linux/uaccess.h>
#include <linux/slab.h>
#include <linux/ctype.h>
#include <linux/of_platform.h>
#include <linux/of_address.h>       // of_iomap
#include <linux/wait.h>				
#include <linux/platform_device.h>  // platform_device
#include <linux/delay.h>			//sleep
#include <linux/io.h>               // ioremap
#include <linux/of.h>               // of_match_ptr
#include <linux/irqreturn.h>		//irq
#include <linux/interrupt.h>		//irq
#include <linux/wait.h>				

MODULE_LICENSE("Dual BSD/GPL");


#include "../inc/my_SPI_fops.h"
#include "../inc/my_SPI_platform_dev.h"

#include "my_SPI_fops.c"
#include "my_SPI_platform_driver.c"
#include "my_SPI_chdev.c"






