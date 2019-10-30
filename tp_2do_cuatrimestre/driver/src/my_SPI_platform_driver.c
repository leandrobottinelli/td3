static volatile void __iomem *td3_spi_base;
static void *cm_per_base;
static void *cm_base;
static void *Mc_SPI0_base;


static const struct of_device_id spi_of_match [] = 
   {
      { .compatible = "td3_spi" },
      { },
   };

   // to register the platform device
   static struct platform_driver td3_platform_driver =
   {
      .probe  = td3_spi_probe,
      .remove = td3_spi_remove,
      .driver =
      {
        .name           = "td3_spi",
        .of_match_table = of_match_ptr(spi_of_match),
      },
   };

   MODULE_DEVICE_TABLE(of, spi_of_match);




/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/*Functions*/

static int td3_spi_probe(struct platform_device *p_pdev){

static uint32_t register_value;
static uint32_t cont=0;


	printk(KERN_INFO "PROBE SPI0\n");

	td3_spi_base = of_iomap(p_pdev->dev.of_node, 0);


//------------------------------------------------------------------------------------------------------------------------

	/*CLOCK MODULE PERIPHERAL Init Configuration*/

	if((cm_per_base=ioremap(CM_PER_BASE, CM_PER_LENGTH))<0){

		printk(KERN_ALERT "IOREMAP CLOCK_PERIPHERAL FAILED\n");
		iounmap(td3_spi_base);
		return -1;
	}

	register_value = ioread32(cm_per_base + CM_PER_SPI0_CLKCTRL_OFFSET);
	register_value &= 0xFFFFFFFE;
	register_value |= 0x2;
	iowrite32(register_value,(cm_per_base + CM_PER_SPI0_CLKCTRL_OFFSET));

//------------------------------------------------------------------------------------------------------------------------

	/*PINMUX Init Configuration*/

	if((cm_base=ioremap(CONTROL_MODULE_BASE, CM_PER_LENGTH))<0){	

		printk(KERN_ALERT "IOREMAP CONTROL_MODULE FAILED\n");
		iounmap(cm_per_base);
		iounmap(td3_spi_base);
		return -1;
	}



	register_value = ioread32(cm_base + CONF_SPI0_SLCK_OFFSET);
	register_value &= ~(CONF_SPI0_SLCK_REGS_CLEAR);
	register_value |= (CONF_SPI0_SLCK_PULL_UP | CONF_SPI0_SLCK_PULL_UP_ENABLE | CONF_SPI0_SLCK_MODE);
	iowrite32(register_value,(cm_base + CONF_SPI0_SLCK_OFFSET));

	register_value = ioread32(cm_base + CONF_SPI0_D0_OFFSET);
	register_value &= ~(CONF_SPI0_D0_REGS_CLEAR);
	register_value |= (CONF_SPI0_D0_PULL_UP | CONF_SPI0_D0_PULL_UP_ENABLE | CONF_SPI0_D0_MODE);
	iowrite32(register_value,(cm_base + CONF_SPI0_D0_OFFSET));

	register_value = ioread32(cm_base + CONF_SPI0_D1_OFFSET);
	register_value &= ~(CONF_SPI0_D1_REGS_CLEAR);
	register_value |= (CONF_SPI0_D1_PULL_UP | CONF_SPI0_D1_PULL_UP_ENABLE | CONF_SPI0_D1_MODE);
	iowrite32(register_value,(cm_base + CONF_SPI0_D1_OFFSET));

	register_value = ioread32(cm_base + CONF_SPI0_CS0_OFFSET);
	register_value &= ~(CONF_SPI0_CS0_REGS_CLEAR);
	register_value |= (CONF_SPI0_CS0_PULL_UP | CONF_SPI0_CS0_PULL_UP_ENABLE | CONF_SPI0_CS0_MODE);
	iowrite32(register_value,(cm_base + CONF_SPI0_CS0_OFFSET));

	printk(KERN_INFO "PINMUX SPI0 SLCK_D0_D1_CS0 INITIALIZED\n");


//------------------------------------------------------------------------------------------------------------------------

	/*SPI0 Init Configuration*/


	if((Mc_SPI0_base=ioremap(Mc_SPI0_BASE_ADDRESS, Mc_SPI0_BASE_LENGTH))<0){
		printk(KERN_ALERT "IOREMAP SPI0 FAILED\n");

		iounmap(cm_base);
		iounmap(cm_per_base);
		iounmap(td3_spi_base);
		return -1;
	}

//------------------------------------------------------------------------------------------------------------------------

	/*SoftReset*/

/*	register_value |= MCSPI0_SYSCONFIG_SOFTRESET;
	iowrite32(register_value,(Mc_SPI0_base + MCSPI_SYSCONFIG_OFFSET));
	register_value=0;

	while (register_value!=1)
    {
        msleep (1);
        register_value = ioread32 (Mc_SPI0_base + MCSPI_SYSCONFIG_OFFSET);
        if ( cont > 4 )
        {
            printk(KERN_ALERT "RESET SPI0 FAILED\n");
            return -EBUSY;
        }
        cont++;
    }
*/
//------------------------------------------------------------------------------------------------------------------------

	register_value = ioread32(Mc_SPI0_base + MCSPI_SYSCONFIG_OFFSET);
	register_value &= ~(MCSPI0_SYSCONFIG_REGS_CLEAR);
	register_value |= (MCSPI0_SYSCONFIG_CLOCKACTIVITY | MCSPI0_SYSCONFIG_SIDLEMODE | MCSPI0_SYSCONFIG_SOFTRESET | MCSPI0_SYSCONFIG_AUTOIDLE);
	iowrite32(register_value,(Mc_SPI0_base + MCSPI_SYSCONFIG_OFFSET));

	register_value = ioread32(Mc_SPI0_base + MCSPI_MODULCTRL_OFFSET);
	register_value &= ~(MCSPI_MODULCTRL_REGS_CLEAR);
	register_value |= (MCSPI_MODULCTRL_FDAA | MCSPI_MODULCTRL_MOA | MCSPI_MODULCTRL_INITDLY | MCSPI_MODULCTRL_SYSTEM_TEST | MCSPI_MODULCTRL_MS | MCSPI_MODULCTRL_PIN34 | MCSPI_MODULCTRL_SINGLE);
	iowrite32(register_value,(Mc_SPI0_base + MCSPI_MODULCTRL_OFFSET));

	register_value = ioread32(Mc_SPI0_base + MCSPI_CH0CONF_OFFSET);
	register_value &= ~(MCSPI_CH0CONF_REGS_CLEAR);
	register_value |= (MCSPI_CH0CONF_PHA | MCSPI_CH0CONF_POL | MCSPI_CH0CONF_CLKD | MCSPI_CH0CONF_EPOL | MCSPI_CH0CONF_WL | MCSPI_CH0CONF_FORCE | MCSPI_CH0CONF_SBE | MCSPI_CH0CONF_SBPOL);
	iowrite32(register_value,(Mc_SPI0_base + MCSPI_CH0CONF_OFFSET));

	register_value = ioread32(Mc_SPI0_base + MCSPI_CH0CTRL_OFFSET);
	register_value|= MCSPI_CH0CTRL_CHANNEL0_ENABLE;
	iowrite32(register_value,(Mc_SPI0_base + MCSPI_CH0CTRL_OFFSET));

	printk(KERN_INFO "SPI0 SYSCONFIG_MODULCTRL_CH0CONF_CH0CTRL INITIALIZED\n");


//------------------------------------------------------------------------------------------------------------------------

	return 0;

/*	while(1){

	iowrite32(0xA2, Mc_SPI0_base + MCSPI_TX0_OFFSET);    
    
    msleep (100);
	}
*/

}


static int td3_spi_remove(struct platform_device *p_pdev){

	printk(KERN_ALERT "REMOVE SPI0\n");

	iounmap(Mc_SPI0_base);
	iounmap(cm_base);
	iounmap(cm_per_base);
	iounmap(td3_spi_base);
	return 0;
}

	/*Interruptions*/

/*
    if((v_irq = platform_get_irq(p_pdev, 0)) < 0)
    {
    	printk(KERN_ERR "ERROR VIRQ \n");

		iounmap(Mc_SPI0_base);
		iounmap(cm_base);
		iounmap(cm_per_base);
		iounmap(td3_spi_base);

       	return 1;         
    }


    if(request_irq(v_irq, (irq_handler_t) td3_spi_handler, IRQF_TRIGGER_RISING, NAME, NULL))
    {
     	printk(KERN_ERR "ERROR REQUEST_IRQ \n");

		iounmap(Mc_SPI0_base);
		iounmap(cm_base);
		iounmap(cm_per_base);
		iounmap(td3_spi_base);

    	 return 1;
    }

    reg_value = ioread32(Mc_SPI0_base + MCSPI_IRQSTATUS_OFFSET);
    reg_value &= ~(MCSPI_IRQSTATUS_REGS_CLEAR);
    iowrite32(reg_value, Mc_SPI0_base + MCSPI_IRQSTATUS_OFFSET); 

    reg_value = ioread32(Mc_SPI0_base + MCSPI_IRQENABLE_OFFSET);
    reg_value &= ~(MCSPI_IRQSTATUS_REGS_CLEAR);
    reg_value |= (MCSPI_IRQENABLE_TX0_EMPTY	| MCSPI_IRQENABLE_TX0_UNDERFLOW | MCSPI_IRQENABLE_RX0_FULL | MCSPI_IRQENABLE_RX0_OVERFLOW);
    iowrite32(reg_value, Mc_SPI0_base + MCSPI_IRQENABLE_OFFSET);

    free_irq(v_irq, NULL);
  
 	irqreturn_t td3_spi_handler(int irq, void *dev_id, struct pt_regs *regs)
	{
	}
	*/