#Makefile for cocotb


#Simulator Settings
SIM?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(PWD)/rtl/SubBytes.sv

TOPLEVEL = SubBytes

MODULE = test_SubBytes
export PYTHONPATH :=$(PWD)/tb

include $(shell cocotb-config --makefiles)/Makefile.sim
