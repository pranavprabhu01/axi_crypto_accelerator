//Description: This module performs Galois Field Multiplication.
//Author: Pranav Prabhu
//Email: pp7437@rit.edu;prnv.prbh@gmail.com

module GFM (input [7:0] i_data_a,input [7:0] i_data_b, output [7:0] o_data);

	//Intermediate Data
	reg [7:0] intr_data;

	//Accumlator
	reg [7:0] acc;

	//Iteration Variable
	int i;

	always_comb begin
	//Initialize	
	 intr_data = i_data_a;
	 acc = 8'h00;
	//Logic: loop through i_data_b; check bit;if its set left shift	
	for(i = 0;i < 8;i = i+1) begin
		if(i_data_b[i] == 1'b1)begin
			acc = acc ^ intr_data;
		end

		//Check if MSB is high then xor with hex 1B
		if(intr_data[7] == 1'b1)begin
			intr_data = (intr_data<<1) ^ 8'h1B;
		end
		else begin
			intr_data = (intr_data<<1);
		end
		
	end
end

	assign o_data = acc;
endmodule
