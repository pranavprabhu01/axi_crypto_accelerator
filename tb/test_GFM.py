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
    """Exhaustive Verification"""
    
    dut._log.info("Starting GFM Module Verification")

    for a in range(256):
        for b in range(256):
            #input vectors
            dut.i_data_a.value = a
            dut.i_data_b.value = b
            #Timer wait for 1ns
            await Timer(1,units="ns")
            
            expected = gfm_reference(a,b)
            actual = dut.o_data.value.integer

            #Assertion
            assert actual == expected,(
                    f"Mismatch for {hex(a)} * {hex(b)}:"
                    f"Expected {hex(expected)},got{hex(actual)}"
                    )


    dut._log.info("Successfully passed 65,536 test vectors")



