#Makefile for cocotb


#Simulator Settings
SIM?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(PWD)/rtl/GFM.sv

TOPLEVEL = GFM

MODULE = test_GFM
export PYTHONPATH :=$(PWD)/tb

include $(shell cocotb-config --makefiles)/Makefile.sim
