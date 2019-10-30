
/*--------------------------------------------------------------------------------------------------------------------------------*/
/*File operations my_SPI*/

static int my_SPI_open (struct inode * my_inode, struct file * my_file){
		printk(KERN_ALERT "my_SPI OPEN\n");


		return 0;

}

/*--------------------------------------------------------------------------------------------------------------------------------*/

static int my_SPI_release (struct inode * my_inode, struct file * my_file){
		printk(KERN_ALERT "my_SPI RELEASE\n");
		return 0;
}

/*--------------------------------------------------------------------------------------------------------------------------------*/

static ssize_t my_SPI_write (struct file * my_file, const char __user * my_user, size_t my_size, loff_t* my_loff){
		printk(KERN_ALERT "my_SPI WRITE\n");
		return 0;
}

/*--------------------------------------------------------------------------------------------------------------------------------*/


static ssize_t my_SPI_read (struct file * my_file, char __user * my_user, size_t my_size , loff_t * my_loff){
		printk(KERN_ALERT "my_SPI READ\n");
		return 0;
}


/*--------------------------------------------------------------------------------------------------------------------------------*/
