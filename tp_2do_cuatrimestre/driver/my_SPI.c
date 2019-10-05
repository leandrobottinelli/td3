#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/err.h>
#include <linux/uaccess.h>
#include <linux/slab.h>
#include <linux/ctype.h>

#define first_minor 0
#define count_minor 1
#define my_SPI "my_SPI"

MODULE_LICENSE("Dual BSD/GPL");

static int my_SPI_open (struct inode *, struct file *);
static int my_SPI_release (struct inode *, struct file *);
static ssize_t my_SPI_write (struct file *, const char __user *, size_t, loff_t*);
static ssize_t my_SPI_read (struct file *, char __user *, size_t, loff_t *);


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


/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*Functions*/


static int drv_init(void) {

int a;

 a = alloc_chrdev_region(&my_dev,first_minor,count_minor,my_SPI);

printk(KERN_ALERT "%d\n",a);


if(a<0)
{
	printk(KERN_ALERT "ERROR ALLOC CHDEV REGION\n");
	return -1;
}



if ( (p_cdev = cdev_alloc() )== NULL )
{
	printk(KERN_ALERT "ERROR CDEV ALLOC\n");
	unregister_chrdev_region(my_dev,count_minor);

	return -1;


}





p_cdev->ops = &my_SPI_fileops;
p_cdev->owner = THIS_MODULE;
p_cdev->dev = my_dev;

a= cdev_add(p_cdev,first_minor, count_minor);

if(a<0)
{
	printk(KERN_ALERT "ERROR CDEV_ADD\n");
	unregister_chrdev_region(my_dev,count_minor);

	return -1;
}


if((my_class = class_create(THIS_MODULE,my_SPI)) == NULL)
{

	cdev_del (p_cdev);
	unregister_chrdev_region(my_dev,count_minor);
	printk(KERN_ALERT "ERROR CLASS_CREATE\n");

	return -1;
}


if((my_device = device_create (my_class,NULL,my_dev,NULL,my_SPI)==NULL))
{	
	class_destroy(my_class);
	cdev_del (p_cdev);
	unregister_chrdev_region(my_dev,count_minor);
	printk(KERN_ALERT "ERROR CLASS_CREATE\n");

	return -1;
}



printk(KERN_ALERT "Hello, world\n");

return 0;
}









static void drv_exit(void) {

device_destroy(my_class, my_dev);
class_destroy(my_class);
cdev_del (p_cdev);
unregister_chrdev_region(my_dev,count_minor);
printk(KERN_ALERT "Goodbye, cruel world\n");
}


/*--------------------------------------------------------------------------------------------------------------------------------*/
/*File operations my_SPI*/

static int my_SPI_open (struct inode * my_inode, struct file * my_file){

}

static int my_SPI_release (struct inode * my_inode, struct file * my_file){

}

static ssize_t my_SPI_write (struct file * my_file, const char __user * my_user, size_t my_size, loff_t* my_loff){

}

static ssize_t my_SPI_read (struct file * my_file, char __user * my_user, size_t my_size , loff_t * my_loff){

}


/*--------------------------------------------------------------------------------------------------------------------------------*/

module_init(drv_init);
module_exit(drv_exit);