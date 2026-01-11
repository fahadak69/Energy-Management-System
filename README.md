This repo contains code for Energy Management System (EMS). EMS can control following microgrid assets:
> BESS
> PV
> Generator
> Load
EMS support following control modes:
> Peak Shaving
> Load Following
> Islanding
> Manual Dispatch
The code strucuture is as follows:
> Control code for various modes is writtned in FPGA fabric (RTL)
> User interface code (MODBUS TCP, webserver, user parameters) is written in Linux (C language)
> A zero copy design has been implemented to transfer read data from PS domain (Linux) to PL(FPGA) using CDMA 
