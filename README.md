# Verilog-HDL-SPI-master

This project mainly aims at establishing an SPI (Serial Peripheral Interface) communication
between the master device (FPGA) and any slave device 
Here, the 4 modes of SPI communication are tested, simulated and verified for
effective communication from the master device(FPGA) to any slave device which we want to
communicate with.
The code has been implemented with two modules, one for Clock Division and
another one which defines the working of the SPI Master. 
The Clock Division module is necessary to ensure that SPI communication happens at a proper clock frequency which is
usually less than the typical clock frequency of the FPGA master device. Generally, we
have a PS (prescale factor) and the output clock is 2^(-PS) times the input clock frequency.

![alt text](https://github.com/Xx-BHU1-xX/Verilog-HDL-SPI-master/blockDiagram.jpeg?raw=true)


## The Clock Division module has the following ports :

### ➔ INPUT:

● iclk: This is the main clock of the FPGA.

● rst: This is the reset input.

● ps: <register> ps is the Prescale factor, i.e the factor by which we want to reduce the clock
frequency of the input clock so that SPI communication can be established. 
  
● mode: <register>  This is the input which is used to select the mode of operation of SPI
Communication. (All four SPI modes are supported)
  
### ➔ OUTPUT:
  
● oclk: oclk is the output that is obtained from this module which gives the resulting clock
frequency at which SPI communication is destined to happen.
  
## The SPI module has the following ports :
  
### ➔ INPUT:
  
● iclk, rst: iclk is the input clock and rst is the input reset.
  
● MISO: MISO is the Master In Slave Out input pin which is used to send data to the
master device.
  
● t: t is an 8 bit vector which represents the Transmission byte to be transmitted from the
master to the slave device.
  
● tv: tv is a single bit input variable that represents a transmission byte valid signal, which
sends a control signal to the fpga board indicating start of trnsmission.
  
● mode, ps: mode and ps are the same as defined above in the clock division module.
  
### ➔ OUTPUT:
  
● r: r is an 8 bit vector which represents a received byte.
  
● rv: rv is the received byte valid output signal which indicated succesful data reception.
  
● CSN: CSN is the chip select signal which is active low, and is used to select the slave
device with which communication is to be established.
  
● MOSI: MOSI is the Master Out Slave In output pin which is used to send data from the
master device.
  
● SCK: SCK is the Serial clock output which represents the clock frequency at which the
SPI communication takes place.
