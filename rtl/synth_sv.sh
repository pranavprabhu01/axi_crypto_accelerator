#!/bin/bash

#Description: This script synthesizes sv file. Pass the file while running the script.
#Example: ./synth_sv.sh ShiftRows ShiftRows.sv
#If Multiple Modules: ./synth_sv.sh MixColumns MixColumns.sv GFM.sv

if ["$#"-lt 2]; then
	echo "Usage: $0 <TopModule> <file1.sv> ...."
	exit 1
fi

TOP_MODULE=$1
shift
FILES=$@
yosys -p "
read_verilog -sv $FILES;
hierarchy -check -top $TOP_MODULE;
proc;
opt;
check;
stat;
synth_ice40 -top $TOP_MODULE
check;
stat"
