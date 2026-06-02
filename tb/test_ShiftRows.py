#Description: Testbench to test ShiftRows using CoCoTB.
#Author: Pranav Prabhu
#Email:pp7437@rit.edu;prnv.prbh@gmail.com

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def shift_row_test(dut):
    #Test vector
    test_vector=""
    test_vector=test_vector.lower()
    #Byte list
    byte_list=[]
    for i in range(0,32,2):
        byte=test_vector[i:i+2]
        byte_list.append(int(byte,16))
    for col in range(4):
        for row in range(4):
            i_matrix[row][col]=byte_list[col*4+row]



