#Description: Testbench to test MixColumns module using CoCoTB.
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


#AES Matrix
AES_MATRIX = [
	[0x02,0x03,0x01,0x01],
	[0x01,0x02,0x03,0x01],
	[0x01,0x01,0x02,0x03],
	[0x03,0x01,0x01,0x02]
	]

def mix_columns_reference(input_128bit):
	"""
	computing mixcolumn transformation matrix
	"""
	#unpack state matrix
	state =[[0]*4 for _ in range(4)]
	for c in range(4):
		for r in range(4):
			shift_amt = ((c*4)+r)*8
			state[r][c] = (input_128bit >> shift_amt) & 0xFF
	#perform GF multiplication op
	res_state = [[0]*4 for _ in range(4)]
	for c in range(4):
		for r in range(4):
			val = 0
			for k in range(4):
				val ^= gfm_reference(AES_MATRIX[r][k],state[k][c])
			res_state[r][c] = val
	
	output_128bit = 0
	for c in range(4):
		for r in range(4):
			shift_amt = ((c*4)+r)*8
			output_128bit |=(res_state[r][c]<<shift_amt)
	
	return output_128bit
@cocotb.test()
async def mixcolumns_test(dut):
	"""Test for MixColumns Module"""
	dut._log.info("Starting MixColumn Verification")
	#input test vectors for dut
	test_vectors = [
	0x455313DB455313DB455313DB455313DB,
	0x00000000000000000000000000000000,
	0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
	]
	
	#128 bit test
	for _ in range(20):
		test_vectors.append(random.getrandbits(128))
	
	for idx,test_val in enumerate(test_vectors):
		#feed input
		dut.i_data.value = test_val
		
		#Delay
		await Timer(1,units="ns") 
		
		#computing reference
		expected = mix_columns_reference(test_val)
		actual = dut.o_data.value.integer
		
		#compare
		assert actual == expected, (
			f"Test Case {idx} Failed!\n"
			f"Input: {hex(test_val)}\n"
			f"Expected: {hex(expected)\n"
			f"Actual: {hex(actual)}"
			)
		
		dut._log.info("MixColumn Verification Passed")
	
