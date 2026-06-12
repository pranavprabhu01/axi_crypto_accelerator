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
		//variables to iterate through row and column
	int r;
	int c;
	//Unpack the input matrix
	always_comb begin
        for ( c = 0; c < 4; c = c + 1) begin
            for ( r = 0; r < 4; r = r + 1) begin
                i_matrix[r][c] = i_data[((c * 4) + r) * 8 +: 8];
            end
        end
    end

endmodule
