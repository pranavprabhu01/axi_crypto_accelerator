//Description:This module performs bitwise XOR with round key bytes.
//Author:Pranav Prabhu
//Email:pp7437@rit.edu;prnv.prbh@gmail.com


`default_nettype none


module AddRoundKey(input logic [127:0] i_data,input logic [127:0] i_roundkey,output logic [127:0] o_data);

	//Perfoming bitwise XOR
	assign o_data = i_data ^ i_roundkey;

endmodule
