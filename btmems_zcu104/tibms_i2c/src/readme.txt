bq76952_mntr_i2c.c is the code that uses system calls for read and write i.e. read and write functions

bq76952_mntr_i2c_ioctlrw.c is the same code as above but read write functions are replaced with ioctl calls with I2C_RDWR option. This has two advantages:
1. It allows read and write in same transaction i.e. using i2c repeated start functionality. Some devices (TI battery gauge 34Z100-G1) requires repeated start for reading from a specific address
2. it is a bit faster and more flexible since it directly uses ioctl calls instead of higher level read and write functions

Use only one of the above code, preferably the second one since its a bit faster and more flexible. However, note that the second code uses ioctl I2C_RDWR options (repeated start) which is not supported
by every device. So make sure the device supports this functinality (TI battery monitor bq76952 and gauge 34z100-g1 do support this functionality)

I have tested this code with TI Battery monitor bq76952. I couldnt test it with  the gauge because gauge slave address (7bit) is fixed at 0x55 which conflicts with EEPROM on board zcu104 board. For production board,
use address translator chip or something like that to change gauge address

Also just as FYI, it could be that TI gauge can also work without repeated start, you can check it when testing the gauge

Useful link: https://www.kernel.org/doc/Documentation/i2c/dev-interface

make sure cadence i2c controller is enabled in the kernel config