# VHDL Microprocessor

## Overview
This project is a microprocessor implemented in VHDL. It consists of several components including registers, ALU (Arithmetic Logic Unit), instruction RAM, data RAM, framebuffer, VGA interface, UART interface, and SPI interface. The microprocessor is designed to perform various tasks and can be programmed to execute custom instructions. In this scenario, I created this ASIP to compute what an arithmetic converges to given some inputs stored in the registers. 

## Features
- **Registers**: Provides storage for temporary data and operands during processing.
- **ALU**: Performs arithmetic and logic operations on data.
- **Instruction RAM**: Stores instructions to be executed by the microprocessor.
- **Data RAM**: Stores data required for processing.
- **Framebuffer**: Facilitates interaction with a display, enabling graphical output.
- **VGA Interface**: Interfaces with VGA display to render graphics.
- **UART Interface**: Facilitates serial communication for data exchange with external devices.
- **SPI Interface**: Enables communication with SPI-compatible devices.

## Usage
1. **Setup**: Ensure that the necessary tools and environment for VHDL development are set up.
2. **Programming**: Write custom instructions or programs and load them into the instruction RAM.
3. **Execution**: Connect to Zybo and write a bitstream.
4. **Interfacing**: Utilize the VGA, UART, and SPI interfaces for display, serial communication, and device interfacing, respectively.

## Development Environment
- **Language**: VHDL
- **Tools**: Xilinx Vivado
- **Block Diagram**: ![ASIPnew](https://github.com/peekay123456/Microprocessor/assets/132108727/05c522d4-e6ec-4924-9895-2c6daaed8d0b)


## Resources
- **Documentation / ISA **: ![image](https://github.com/peekay123456/Microprocessor/assets/132108727/7885e0e3-1955-4abc-861d-4921814e457d), ![image](https://github.com/peekay123456/Microprocessor/assets/132108727/91a95cfd-b01b-4c38-aca4-187b7a165b5a),
  ![image](https://github.com/peekay123456/Microprocessor/assets/132108727/57defc2c-77ac-4f78-a71e-e3994fe1fe3b) 





