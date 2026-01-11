this xilinx example is for standalone i2d which I accidently used with a linux project. i2c_bms is the 
file I modified for battery guage but this wont work on linux, you maybe able to use it though for standalone
system (note the comments in i2c_bms file regarding sem and post use, those are invalid since this code is not 
for linux)