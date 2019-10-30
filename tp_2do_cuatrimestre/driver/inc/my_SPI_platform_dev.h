
/*Defines probe function*/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


static int td3_spi_probe(struct platform_device *p_pdev);
static int td3_spi_remove(struct platform_device *pdev);


/*Clock Module Peripheral Regs*/


#define CM_PER_BASE 0x44E00000
#define CM_PER_LENGTH 0x400
#define CM_PER_SPI0_CLKCTRL_OFFSET 0x4C
#define CM_PER_MODULE_MASK
#define MODULE_MODE_ENABLE 0x02

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*Control Module Regs*/
#define CONTROL_MODULE_BASE   0x44E10000
#define CONTROL_MODULE_LENGTH 0x1000

#define CONF_SPI0_SLCK_OFFSET			0X950
#define CONF_SPI0_SLCK_REGS_CLEAR 		((0x1<<4) | (0x1<<3) | (0x1<<0))
#define CONF_SPI0_SLCK_MODE				(0x0<<0)
#define CONF_SPI0_SLCK_PULL_UP_ENABLE	(0x1<<3)
#define CONF_SPI0_SLCK_PULL_UP 			(0x1<<4)

#define CONF_SPI0_D0_OFFSET			0X954
#define CONF_SPI0_D0_REGS_CLEAR 	((0x1<<4) | (0x1<<3) | (0x1<<0))
#define CONF_SPI0_D0_MODE			(0x0<<0)
#define CONF_SPI0_D0_PULL_UP_ENABLE	(0x1<<3)
#define CONF_SPI0_D0_PULL_UP		(0x1<<4)


#define CONF_SPI0_D1_OFFSET	 		0X958
#define CONF_SPI0_D1_REGS_CLEAR 	((0x1<<4) | (0x1<<3) | (0x1<<0))
#define CONF_SPI0_D1_MODE			(0x0<<0)
#define CONF_SPI0_D1_PULL_UP_ENABLE	(0x1<<3)
#define CONF_SPI0_D1_PULL_UP		(0x1<<4)


#define CONF_SPI0_CS0_OFFSET 		 	0X95C
#define CONF_SPI0_CS0_REGS_CLEAR 		((0x1<<4) | (0x1<<3) | (0x1<<0))
#define CONF_SPI0_CS0_MODE				(0x0<<0)
#define CONF_SPI0_CS0_PULL_UP_ENABLE	(0x1<<3)
#define CONF_SPI0_CS0_PULL_UP			(0x1<<4)

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*Pinout Beagle Bone*/

#define BB_SPI0_CS0 17
#define BB_SPI0_D1	18
#define BB_SPI0_D0	21
#define BB_SPI0_CLK	22

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*SPI Regs*/


#define Mc_SPI0_BASE_ADDRESS   0x48030000
#define Mc_SPI0_BASE_LENGTH    0x1000


#define MCSPI_SYSCONFIG_OFFSET 			0x110

#define MCSPI0_SYSCONFIG_REGS_CLEAR 	((0x3<<8) | (0x3<<3) | (0x1<<1) | (0x1<<0))
#define MCSPI0_SYSCONFIG_AUTOIDLE 		(0x0<<0)
#define MCSPI0_SYSCONFIG_SOFTRESET 		(0x0<<1)
#define MCSPI0_SYSCONFIG_SIDLEMODE 		(0x1<<3)
#define MCSPI0_SYSCONFIG_CLOCKACTIVITY 	(0x3<<8)



#define MCSPI_MODULCTRL_OFFSET	     0x128

#define	MCSPI_MODULCTRL_REGS_CLEAR	(0x1F)
#define MCSPI_MODULCTRL_SINGLE		(0x1<<0)
#define MCSPI_MODULCTRL_PIN34		(0x0<<1)
#define MCSPI_MODULCTRL_MS 			(0x0<<2)
#define MCSPI_MODULCTRL_SYSTEM_TEST (0x0<<3)
#define MCSPI_MODULCTRL_INITDLY 	(0x0<<4)
#define MCSPI_MODULCTRL_MOA 		(0x0<<7)
#define MCSPI_MODULCTRL_FDAA		(0x0<<8)



#define MCSPI_CH0CONF_OFFSET 		0x12C

#define MCSPI_CH0CONF_REGS_CLEAR 	((1<<24) | (1<<23) | (1<<20) | (0xF<<7) | (0x1<<6) | (0xF<<2) | (0x1<<1) | (0x1<<0))
#define MCSPI_CH0CONF_PHA 			(0x1<<0)
#define MCSPI_CH0CONF_POL 			(0x1<<1)
#define MCSPI_CH0CONF_CLKD 			(0xA<<2)
#define MCSPI_CH0CONF_EPOL 			(0x1<<6)
#define MCSPI_CH0CONF_WL			(0x7<<7)
#define MCSPI_CH0CONF_FORCE			(0x1<<20)
#define MCSPI_CH0CONF_SBE 			(0x0<<23)
#define MCSPI_CH0CONF_SBPOL 		(0x1<<24)

		
#define MCSPI_CH0CTRL_OFFSET   			0x134
#define MCSPI_CH0CTRL_CHANNEL0_ENABLE   (0x1<<0)



#define MCSPI_TX0_OFFSET			0x138
#define MCSPI_RX0_OFFSET 			0x13C


#define MCSPI_IRQSTATUS_OFFSET   		0x118
#define MCSPI_IRQSTATUS_REGS_CLEAR 		((0x1<<3)|(0x1<<2)|(0x1<<1)|(0x1<<0))
#define MCSPI_IRQSTATUS_TX0_EMPTY		(0x1<<0)		
#define MCSPI_IRQSTATUS_TX0_UNDERFLOW	(0x1<<1)
#define MCSPI_IRQSTATUS_RX0_FULL		(0x1<<2)
#define MCSPI_IRQSTATUS_RX0_OVERFLOW	(0x1<<3)


#define MCSPI_IRQENABLE_OFFSET   		0x11C
#define MCSPI_IRQENABLE_REGS_CLEAR 		((0x1<<3)|(0x1<<2)|(0x1<<1)|(0x1<<0))
#define MCSPI_IRQENABLE_TX0_EMPTY		(0x1<<0)		
#define MCSPI_IRQENABLE_TX0_UNDERFLOW	(0x1<<1)
#define MCSPI_IRQENABLE_RX0_FULL		(0x1<<2)
#define MCSPI_IRQENABLE_RX0_OVERFLOW	(0x1<<3)


/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
