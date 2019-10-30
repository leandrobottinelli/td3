


static int my_SPI_open (struct inode *, struct file *);
static int my_SPI_release (struct inode *, struct file *);
static ssize_t my_SPI_write (struct file *, const char __user *, size_t, loff_t*);
static ssize_t my_SPI_read (struct file *, char __user *, size_t, loff_t *);



static int drv_init(void);
static void drv_exit(void);