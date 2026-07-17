#Description: Testbench to test GF multiplication using CoCoTB.
#Author: Pranav Prabhu
#Email:pp7437@rit.edu;prnv.prbh@gmail.com

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def GFM_test(dut):
