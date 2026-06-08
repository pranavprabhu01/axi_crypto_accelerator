#Description: Testbench to test AddRoundKey module using CoCoTB.
#Author: Pranav Prabhu
#Email:pp7437@rit.edu;prnv.prbh@gmail.com

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def addroundkey_test(dut):
    #Test Vector
    test_vector_i_data ="011"
    test_vector_roundkey = "59"
     
    #computing xor;converting to hex
    test_o_data = int(test_vector_i_data,16) ^int(test_vector_roundkey,16)

    #Stimulus to DUT
    dut.i_data.value = int(test_vector_i_data,16);
    dut.i_roundkey.value = int(test_vector_roundkey,16);

    #wait for 1ns
    await Timer(1,unit="ns")

    rcvd_op=int(dut.o_data.value)

    assert rcvd_op == test_o_data,\
            f"Failed for test vector data ={test_vector_i_data},test vector round key = {test_vector_roundkey}:Expected {hex(test_o_data)},got{hex(rcvd_op)}"

    dut._log.info(f"Passed for test vector data ={test_vector_i_data},test vector round key = {test_vector_roundkey}:Expected {hex(test_o_data)},got{hex(rcvd_op)}")


