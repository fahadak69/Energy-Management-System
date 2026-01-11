*********************************** FAHAD NOTES *********************************************************************************
This application provides an example how to receive GPIO interrupt and take some action once interrupt is received

There are two ways to process GPIO interrupt. One using xilinx gpio-xilinx.c kernel driver other is to use linux uio driver uio_pdrv_genirq.c


- axigpio_intr_uio.c is the application file to process gpio interrupt using linux UIO driver
- axigpio_intr_xlnx.c is the application file to process gpio interrupt using xilinx gpio linux driver
- axigpio_PB_intr.c is the application file to proces gpio interrupt using event method. This doesnt completely work. Dont use this!
Use only one of the files at a time, comment out the other

/////////// Using UIO Driver: //////////////
In order to use UIO application:

> Enable UIO driver in kernel config (under Device Driver->Userspace I/O) :
	<*> Userspace I/O platform driver with generic IRQ handling
	<*> Userspace platform driver with generic irq and dynamic memory
	<*> Xilinx AI Engine driver
	
> In system-user.dtsi, add following:

/include/ "system-conf.dtsi"
/ {
    chosen {
        bootargs = "earlycon clk_ignore_unused   uio_pdrv_genirq.of_id=generic-uio";
        stdout-path = "serial0:115200n8";
    };
};
  
&axi_gpio_0 {
    compatible = "generic-uio";
};

Above device tree code is taken from xilinx wiki note https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842490/Testing+UIO+with+Interrupt+on+Zynq+Ultrascale

/////////// Using Xlinx GPIO Driver: //////////////
In order to use application with xilinx gpio driver:

> Use modified gpio-xilinx.c driver in which omar modified interrupt handler to send signal to userspace application when gpio interrupt arrives

> Enable GPIO and GPIO key related drivers in kernel config:
	Device Drivers
		GPIO Support
			Xilinx GPIO support
			Xilinx Zynq GPIO support
		Input device support
			Keyboards
				GPIO Buttons
				Polled GPIO buttons
				
> Add following to system-user.dtsi (this assumed 4 inputs to GPIO IP):

gpio-keys {
    compatible = "gpio-keys";
    #address-cells = <1>;
    #size-cells = <0>;
    autorepeat;
    SW0 {
        label = "SW0";
        gpios = <&axi_gpio_0 0x0 0x0 0x0>;
        linux,code = <103>;
	debounce-interval = <100>;
        gpio-key,wakeup;
        autorepeat;
    };
    SW1 {
        label = "SW1";
        gpios = <&axi_gpio_0 0x1 0x0 0x0>;
        linux,code = <108>;
	debounce-interval = <100>;
        gpio-key,wakeup;
        autorepeat;
    };
    SW2 {
        label = "SW2";
        gpios = <&axi_gpio_0 0x2 0x0 0x0>;
        linux,code = <105>;
	debounce-interval = <100>;
        gpio-key,wakeup;
        autorepeat;
    };
    SW3 {
        label = "SW3";
        gpios = <&axi_gpio_0 0x3 0x0 0x0>;
        linux,code = <106>;
	debounce-interval = <100>;
        gpio-key,wakeup;
        autorepeat;
    };
 };


Above device tree code has come from xilinx wiki:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841846/AXI+GPIO
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842398/Linux+GPIO+Driver

An alternative way to GPIO Keys (but still using xilinx gpio driver) is gpio export method. To use that mehtod:
> Make sure GPIO key nodes (shown above) are not present in device tree
> boot linux on the board
> go to /sys/class/gpio directory
> there should be 3 GPIO chips (two hard cores, and one your GPIO IP)
> To know which controller/chip is your IP, go inside each of the chips directory and do "cat ngpio" 
> ngpio tells number of GPIOs connected to the controller. The one that matches your IP will be your controller
> now export all the GPIOs of the controller (using echo xxx > export, where xxx is the gpio number starting from the base)
> this will create directory for each GPIO exported
> go inside the directory
> then do echo "rising" > edge, this will enable interrupt for that gpio. Similarly enable it for all the GPIOs
> after that you can use same application to received and process interrupts 
> you can also perform above steps in the userspace application instead of on terminal