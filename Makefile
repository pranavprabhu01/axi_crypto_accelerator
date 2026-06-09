#Makefile for cocotb


#Simulator Settings
SIM?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(PWD)/rtl/AddRoundKey.sv

TOPLEVEL = AddRoundKey

MODULE = test_AddRoundKey
export PYTHONPATH :=$(PWD)/tb

include $(shell cocotb-config --makefiles)/Makefile.sim
