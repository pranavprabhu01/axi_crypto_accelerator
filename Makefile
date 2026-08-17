#Makefile for cocotb


#Simulator Settings
SIM?= icarus
TOPLEVEL_LANG ?= verilog

#RTL Files
VERILOG_SOURCES +=$(PWD)/rtl/GFM.sv
VERILOG_SOURCES +=$(PWD)/rtl/MixColumns.sv


#Top level SV module name
TOPLEVEL = MixColumns

MODULE = test_MixColumns
export PYTHONPATH :=$(PWD)/tb

include $(shell cocotb-config --makefiles)/Makefile.sim
