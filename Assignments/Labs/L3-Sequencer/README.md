# Lab 1

## Description

This is a simple lab in which our group got familiar with the Xilinx ISE, and
reading/utilizing Verilog code. It involved the analysis of sequencers, clock dividers, debouncers, and register files, as well as a simple modification of some code to alter the formatting of code to avoid the initial hardcoding implementation.

## Included Files

### model_uart.v
This module utilized a UART connection, in which bytes were sent over from the Nexys3 FPGA board to a putty connection on a desktop computer. The goal was to use the switches and buttons on the FPGA board to create an instruction command, and these bytes were then sent over to the desktop using UART

### tb.v
The testbench was modified to avoid the hardcoding of instructions. Instead,
it was changed to allow a set of instructions to be read in from a file.