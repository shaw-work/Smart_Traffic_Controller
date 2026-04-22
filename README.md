# Smart_Traffic_Controller
Smart FPGA traffic controller using Verilog HDL with FSM, emergency priority, pedestrian mode and Vivado simulation.
# Smart Traffic Controller on FPGA (Artix-7)

A modular Verilog HDL project implementing a smart 4-way traffic control system designed in Vivado for Xilinx Artix-7 FPGA devices.

## Features

* North-South / East-West traffic sequencing
* Yellow transition states
* Pedestrian crossing request mode
* Emergency vehicle priority mode
* Night mode blinking yellow lights
* Countdown timer display using 7-segment
* Testbench verified in Vivado Simulator

## Tools Used

* Verilog HDL
* Xilinx Vivado
* Artix-7 FPGA Target (generic part)

## Project Structure

```text
rtl/           Design source files
tb/            Testbench
constraints/   XDC pin constraints
screenshots/   Simulation proof
README.md
```

## Simulation Result

Behavioral simulation verified successfully.

## Future Improvements

* Vehicle sensor based adaptive timing
* UART control panel
* LCD status display
* FPGA board deployment

## Author

Built as an RTL / FPGA portfolio project.
