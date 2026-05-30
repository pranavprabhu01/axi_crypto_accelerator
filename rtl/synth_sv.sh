#!/bin/bash

#Description: This script synthesizes sv file. Pass the file while running the script.
#Example: ./synth_sv.sh ShiftRows.sv ShiftRows

yosys -p "
read_verilog -sv $1;
hierarchy -check -top $2;
proc;
opt;
check;
stat;
synth_ice40 -top $2
check;
stat"
