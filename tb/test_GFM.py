#Description: Testbench to test GF multiplication using CoCoTB.
#Author: Pranav Prabhu
#Email:pp7437@rit.edu;prnv.prbh@gmail.com

import cocotb
from cocotb.triggers import Timer
import random

def gfm_reference(a,b):

    acc = 0
    intr_data = a &0xFF

    for i in range(8):
        if(b>>i)&1:
            acc^=intr_data

        if intr_data & 0x80:
            intr_data = ((intr_data<<1)^0x1B)&0xFF
        else:
            intr_data = (intr_data<<1)&0xFF
    return acc & 0xFF

@cocotb.test()
async def GFM_test(dut):
    #test vector
    test_vector_a =""
    test_vector_b =""

