Description: This module performs Galois Field Multiplication.
Author: Pranav Prabhu
Email: pp7437@rit.edu;prnv.prbh@gmail.com

module GFM (input [7:0] i_data_a,input [7:0] i_data_b, output [7:0] o_data);

	//Intermediate Data
	logic [7:0] intr_data[0:7];

	//Iteration Variable
	int i;

	//Logic: loop through i_data_b; check bit;if its set left shift	
	for(i = 7;i > -1;i = i-1) begin
		if(i_data_b[i] == 1'b1)begin
		end
		else begin
		end
	end
endmodule
