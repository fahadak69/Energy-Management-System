Difference between axicdma_intr.c and axicdma.c app is that former app uses interrupt using UIO driver to know when CDMA status is done while latter 
keeps reading CDMA IP status register (which wastes CPU cycles)

For axicdma_intr.c, make sure you make cdma IP generic-uio compatible in system-user.dtsi 

You can also modify  axicdma_intr.c to use uio driver for  CDMA register setup and read/write instead of using /dev/mem. It will be very similar
to your axi gpio application using uio driver (axigpio_intr_uio.c) that omar helped to develop. Note you still need to know physical address of
PS DDR memory location (same as in /dev/mem)

I think using /dev/mem for register setup/read/write and uio for interrupt is the best way for cdma transfer. It allows direct access to device register
(without even using any kernal driver, not even uio driver) and uio driver is only used for interrupt 

Note for using uio, make sure axi cdma device node is made compatible with uio in system-user.dtsi

The only time you may not want to use /dev/mem is if for security reasons (that too if someone objects otherwise per Omar /dev/mem is commonly used) 
or something else where you dont want kernel memory to be accessible by userspace

You can also instead use xilinx axi cdma driver (instead of using /dev/mem or uio driver). However, that will not be a zero copy design (unless you
use John Lynn DMA proxy character driver and DMA proxy test approach (see your DMA Example folder under Resources) that he used for DMA IP but in that 
case you will have to modify his code for CDMA) and will also have multiple hops (userspace -> kernel -> device instead of userspace->device). 
The only reason why you would want to use axi cdma kernel driver (instead of /dev/mem or uio) is if you need to use some kernel specific 
feature (for instance, per Omar,  scheduling is something that requires kernel) 