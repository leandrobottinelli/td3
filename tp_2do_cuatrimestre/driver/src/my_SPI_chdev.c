#define first_minor 0
#define count_minor 1
#define my_SPI "my_SPI"

static int drv_init(void);
static void drv_exit(void);


static dev_t my_dev;
static struct cdev *p_cdev;
static struct class *my_class;
static struct device *my_device;

static struct file_operations my_SPI_fileops = {
    .owner = THIS_MODULE,
    .open = my_SPI_open,
    .release = my_SPI_release,
    .read = my_SPI_read,
    .write = my_SPI_write
};


/*--------------------------------------------------------------------------------------------------------------------------------*/

static int drv_init(void) {

int value;

printk(KERN_INFO "SPI driver INIT\n");


if((value=alloc_chrdev_region(&my_dev,first_minor,count_minor,my_SPI))<0){

	printk(KERN_ALERT "ERROR ALLOC CHDEV REGION FAILED\n");
	return value;
}

printk(KERN_INFO "SPI chrdev_region alloc\n");



if ( (p_cdev = cdev_alloc() )== NULL){

	printk(KERN_ALERT "ERROR CDEV ALLOC FAILED\n");
	unregister_chrdev_region(my_dev,count_minor);

	return -1;


}

printk(KERN_INFO "SPI cdev alloc\n");


p_cdev->ops = &my_SPI_fileops;
p_cdev->owner = THIS_MODULE;
p_cdev->dev = my_dev;


printk(KERN_INFO "SPI cdev init\n");



if((value=cdev_add(p_cdev,my_dev, count_minor))<0){

	printk(KERN_ALERT "ERROR CDEV_ADD FAILED\n");
	unregister_chrdev_region(my_dev,count_minor);

	return value;
}


printk(KERN_INFO "SPI cdev added\n");


if((my_class = class_create(THIS_MODULE,my_SPI)) == NULL)
{
	printk(KERN_ALERT "ERROR CLASS_CREATE FAILED\n");
	cdev_del (p_cdev);
	unregister_chrdev_region(my_dev,count_minor);

	return -1;
}

printk(KERN_INFO "SPI class created\n");



if((my_device = device_create (my_class,NULL,my_dev,NULL,my_SPI))==NULL)
{	
	printk(KERN_ALERT "ERROR DEVICE_CREATE FAILED\n");
	class_destroy(my_class);
	cdev_del (p_cdev);
	unregister_chrdev_region(my_dev,count_minor);

	return -1;
}

printk(KERN_INFO "SPI device created\n");
printk(KERN_INFO "SPI driver ATTACHED\n");



if(platform_driver_register(&td3_platform_driver) < 0)
{

	printk(KERN_ALERT "PLATFORM_DRIVER_REGISTER FAILED\n");
    device_destroy(my_class, my_dev);
	class_destroy(my_class);
	cdev_del (p_cdev);
	unregister_chrdev_region(my_dev,count_minor);
	return -1;

}


printk(KERN_INFO "SPI platform driver registered\n");

return 0;

}



/*--------------------------------------------------------------------------------------------------------------------------------*/


static void drv_exit(void) {

	printk(KERN_ALERT "SPI driver EXIT\n");

	platform_driver_unregister(&td3_platform_driver);
	device_destroy(my_class, my_dev);
	class_destroy(my_class);
	cdev_del (p_cdev);
	unregister_chrdev_region(my_dev,count_minor);
	printk(KERN_INFO "SPI driver DESATTACHED\n");

}



module_init(drv_init);
module_exit(drv_exit);










