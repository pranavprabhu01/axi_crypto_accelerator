//Description: This module multiplies state matrix with a constant matrix.
//Author: Pranav Prabhu
//Email:pp7437@rit.edu;prnv.prbh@gmail.com

module MixColumns(input logic [127:0]i_data,output logic [127:0]o_data);

	//LUT of constant matrix
	reg [8:0]aes_matrix[3:0][3:0] = '{
		//Column:0	1	2	3
		'{8'h02,8'h03,8'h01,8'h01},	//Row 0
		'{8'h01,8'h02,8'h03,8'h01},	//Row 1
		'{8'h01,8'h01,8'h02,8'h03},	//Row 2
		'{8'h03,8'h01,8'h01,8'h02}	//Row 3
		};

endmodule
