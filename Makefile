#Makefile for cocotb

#Simulator Settings
SIM?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(PWD)/rtl/ShiftRows.sv

TOPLEVEL = ShiftRows

MODULE = test_ShiftRows
export PYTHONPATH :=$(PWD)/tb

include $(shell cocotb-config --makefiles)/Makefile.sim
