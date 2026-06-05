#Description: Testbench to test ShiftRows using CoCoTB.
#Author: Pranav Prabhu
#Email:pp7437@rit.edu;prnv.prbh@gmail.com

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def shift_row_test(dut):
    #Test vector
    test_vector="00112233445566778899aabbccddeeff"
    test_vector=test_vector.lower()
    i_matrix=[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    #Byte list
    byte_list=[]
    for i in range(0,32,2):
        byte=test_vector[i:i+2]
        byte_list.append(int(byte,16))

    byte_list = list(reversed(byte_list))
    for col in range(4):
        for row in range(4):
            i_matrix[row][col]=byte_list[col*4+row]
    i_comparemat=[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    #Assigning matrix values row 1
    i_comparemat[0][0]=i_matrix[0][0];
    i_comparemat[0][1]=i_matrix[0][1];
    i_comparemat[0][2]=i_matrix[0][2];
    i_comparemat[0][3]=i_matrix[0][3];
    
    #Assigning matrix values row 2
    i_comparemat[1][0]=i_matrix[1][1];
    i_comparemat[1][1]=i_matrix[1][2];
    i_comparemat[1][2]=i_matrix[1][3];
    i_comparemat[1][3]=i_matrix[1][0];
    
    #Assigning matrix values row 3
    i_comparemat[2][0]=i_matrix[2][2];
    i_comparemat[2][1]=i_matrix[2][3];
    i_comparemat[2][2]=i_matrix[2][0];
    i_comparemat[2][3]=i_matrix[2][1];
    
    #Assigning matrix values row 4
    i_comparemat[3][0]=i_matrix[3][3];
    i_comparemat[3][1]=i_matrix[3][0];
    i_comparemat[3][2]=i_matrix[3][1];
    i_comparemat[3][3]=i_matrix[3][2];
    
    expected_byteop=[0]*16;
    #packing into bytelist
    for col in range(4):
        for row in range(4):
            expected_byteop[col*4+row]=i_comparemat[row][col]
    
    expected = 0
    for b in reversed(expected_byteop):
    	expected = (expected<<8)|b
    
    
    #Stimulus to DUT
    dut.i_data.value = int(test_vector,16);
    
    #Wait for 1ns
    await Timer(1,units="ns")
    
    rcvd_op = int(dut.o_data.value)
    
    assert rcvd_op == expected,\
    	f"Failed for test vector ={test_vector}:Expected {hex(expected)},got{hex(rcvd_op)}"
    dut._log.info(f"Passed for test vector ={test_vector}:Expected {hex(expected)},got{hex(rcvd_op)}")
    			
    
    





