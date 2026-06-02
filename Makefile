#Makefile for cocotb

SIM?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(PWD)/rtl/ShiftRows.sv
