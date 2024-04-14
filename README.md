# Pipelined CPU

This is a work in progress project!

It is a Verilog implementation for a pipelined CPU. It is heavily inspired by [James Sharman's design](https://www.youtube.com/watch?v=3iHag4k4yEg&list=PLFhc0MFC8MiCDOh3cGFji3qQfXziB9yOw).

This project (once complete) will allow for complete simulation of the CPU and peripherals.

Currently the CPU uses 8-bit data busses and a 16-bit address bus (i.e., an 8-bit CPU). However, I will extend the CPU to be a 16-bit CPU to allow simpler instruction decoding and more instructions.

## Tools

icarusverilog is used to compile and simulate the CPU.  
The machine code is assembled with [bespokeasm](https://github.com/michaelkamprath/bespokeasm?tab=readme-ov-file).
